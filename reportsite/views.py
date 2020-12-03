import bs4
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from django.urls import reverse
from django.utils.timezone import now
from django.views.decorators.http import require_http_methods

# Views go here. Sorta like routes in Flask

# Import models

from .models import *
#for cookies
from django.core import signing
import json
from .populateCityTable import populateCityTable

COOKIENAME="reportsystem"
MAX_SEVERITY=80

#actually login page
def home_page(request):
    #render this specific request on the given template
    return render(request, 'home.html', {'loggedIn':False})

#make a report page
def make_report(request):
    #attempt cookie
    cookie=checkCookie(request)
    if cookie is not None:
        #grab all cities, crimes, and pass to report form
        cities=City.objects.all()
        crimes=Crime.objects.all()
        return render(request, 'makereport.html', {'loggedIn':True, 'cities':cities, 'crimes':crimes, 'role':cookie["role"]})
    #if any steps fail, return forbidden
    return HttpResponse("AUTHENTICATION REQUIRED",status=401)

#where agents and informants review reports
def review_reports(request):
    cookie=checkCookie(request)
    if cookie is not None:
        totalreports=None
        #initial filter
        totalreports=Report.objects.filter(investigationqueue__isnull=True)
        #if cookie role is 2, give full. If 1, give only in their city
        if cookie["role"]==1:
            #get current user city
            currentUserCity=City.objects.get(citizen__id=cookie["id"])
            totalreports=totalreports.filter(city=currentUserCity)
            #further filter - user can't comment on posts they've commented on already
            totalreports=totalreports.filter(comment__informant__id__isnull=True)
        elif cookie["role"]==2:
            totalreports=totalreports.all()
        else:
            return HttpResponse("UNAUTHORIZED USER",status=403)
        return render(request, 'reviewreports.html',  {'reports':totalreports,'ten':range(11),'loggedIn':True,'role':cookie["role"]})

#receive comments from report review
def receive_comment(request):
    cookie = checkCookie(request)
    if cookie is not None:
        if cookie["role"] in (1,2):
            try:
                #attempt to retrieve items from request
                priority=int(request.POST["inlineRadioOptions"])
                remarks=request.POST["remarks"]
                report=Report.objects.get(id=request.POST["reportID"])
                #commit to comment entry
                newComment=Comment(content=remarks,priority=priority)
                newComment.informant=Citizen.objects.get(id=cookie["id"])
                newComment.reportID=report
                newComment.save()
            except:
                pass
            return HttpResponseRedirect(reverse('reportsite:reportreview'))

def receive_escalation(request):
    cookie=checkCookie(request)
    if cookie is not None:
        report=None
        try:
            report=request.POST["reportID"]
            report=Report.objects.get(id=report)
        except:
            return HttpResponse("BAD DATA")
        #no duplicates in InvestigationQueue
        if InvestigationQueue.objects.filter(reportID=report):
            return HttpResponse("BAD DATA")
        #verify sender
        agent=None
        try:
            agent=Citizen.objects.get(id=cookie["id"])
        except:
            return HttpResponse("UNAUTHORIZED USER")
        if agent.role != 2:
            return HttpResponse("UNAUTHORIZED USER")
        #otherwise commit
        newEscalation=InvestigationQueue(agentID=agent,reportID=report,priority=2)
        newEscalation.save()
        return HttpResponse("Escalation successful.")

#where agents review city danger
def review_cities(request):
    #verify cookie
    cookie=checkCookie(request)
    if cookie is not None:
        #grab cities
        if cookie["role"]==2:
            #dict will store cities and risk values to pass to templating
            dictCities={}
            cities=City.objects.all()
            for city in cities:
                totalRisk=0
                #first isolate reports that are for this city and not on the investigation queue
                for report in Report.objects.filter(investigationqueue__isnull=True).filter(city=city):
                    #check every comment for a given report and add priority given by user to the count
                    for comment in Comment.objects.filter(reportID=report):
                        totalRisk+=comment.priority
                dictCities.update({city.cityName:totalRisk})



            return render(request,'reviewcities.html',{'cities':dictCities,'loggedIn':True,'role':cookie["role"]})
    return HttpResponse("UNAUTHORIZED ACCESS")

#where administrators can adjust the crime definitions
def update_crimes(request):
    cookie=checkCookie(request)
    if cookie is not None:
        # check is actually admin
        try:
            #retrieve crimes
            crimes=Crime.objects.all()
            #render page
            return render(request,'updatecrimes.html',{'severityMax':range(MAX_SEVERITY),'crimes':crimes,'loggedIn':True,'role':cookie["role"]})
        except:
            return HttpResponse("UNAUTHORIZED ACCESS")
    #don't let in if not right cookie
    return HttpResponse("UNAUTHORIZED ACCESS")

@require_http_methods(["POST"])
def login(request):
    try:
        user=request.POST["id"]
        password=request.POST["pass"]
        # check database for login entry
        query=Citizen.objects.filter(id=user,password=password)
        #if positive match
        if query.exists():
            #make response with cookie
            user=query.values()[0]
            #user found, redirect to page when done
            #different endpoint depending on user role
            response=None
            if user['role']<=1:
                response=HttpResponseRedirect(reverse('reportsite:report'))
            elif user['role']==2:
                response = HttpResponseRedirect(reverse('reportsite:reportreview'))
            elif user['role']==3:
                response = HttpResponseRedirect(reverse('reportsite:updatecrimes'))
            #https://stackoverflow.com/questions/3420122/filter-dict-to-contain-only-certain-keys
            #sign value with secret key using built in django encryption to save this dict for later
            value=signing.dumps({field:user[field] for field in ['role','id']})
            #save into cookie :)
            response.set_signed_cookie(COOKIENAME,value)
            return response
        #if user no exist, redirect back to page (TODO: add error message for login failure)
    except ValueError:
        pass
        #probably nothing sent, just gonna pretend we didn't that..
    return HttpResponseRedirect(reverse('reportsite:home'))

def logout(request):
    logoutresponse=HttpResponseRedirect(reverse('reportsite:home'))
    logoutresponse.delete_cookie(COOKIENAME)
    return logoutresponse


@require_http_methods(["POST"])
#Receive report data POSTed from page, attempt to validate and commit to database. Tell client how it goes.
def receive_report(request):
    #check cookie
    cookie=checkCookie(request)
    if cookie is not None:
        #valid user
        patriot=cookie['id']
        # now validate sent data
        validData = True
        try:
            traitor_first,traitor_last=request.POST["citizen"].split()
        except:

            return HttpResponse("Failure")
        city=request.POST["city"].strip()
        info=request.POST["info"]
        #validate data before doing anything intensive
        if not (Citizen.objects.filter(firstName=traitor_first.strip(), lastName=traitor_last.strip()).exists()):
            validData=False
        if not (City.objects.filter(cityName=city).exists()):
            validData=False
        #crimes needs to be sanitized before use
        crimes=[]
        # set to invalid to start
        validData=False
        crimeSoup=bs4.BeautifulSoup(request.POST["crimes"])
        for item in crimeSoup.findAll('li'):
            newCrime=item.text.strip()
            #if any of these bad, data is bad
            if Crime.objects.filter(crimeName=newCrime).exists():
                crimes.append(newCrime)
                #if at least one succeeds, set to valid to overwrite
                validData=True
            else:
                validData=False
                break
        #if all data authenticated against database, go ahead and create a report
        if validData:
            try:
                newRecord=Report()
                newRecord.patriot=Citizen.objects.get(pk=patriot)
                newRecord.city=City.objects.get(cityName=city)
                newRecord.traitor=Citizen.objects.get(firstName=traitor_first.strip(), lastName=traitor_last.strip())
                newRecord.remarks=info
                newRecord.priority=0
                newRecord.save()
                #now add crimes :)
                for crime in crimes:
                    newRecord.crimeName.add(Crime.objects.get(crimeName=crime))
                #commit
                newRecord.save()
            except Exception as e:
                print("Error",e)
                return HttpResponse("Failure")
            return HttpResponse("Success")

        #Failure
        return HttpResponse("Failure")


#check cookies, return cookie contents
def checkCookie(request):
    #attempt to grab cookie
    cookie=None
    try:
        cookie=request.get_signed_cookie(COOKIENAME)
    except:
        return None
    #load cookie to pass to templating and authenticate
    return signing.loads(cookie)
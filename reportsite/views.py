from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from django.urls import reverse
from django.views.decorators.http import require_http_methods

# Views go here. Sorta like routes in Flask

# Import models

from .models import *
#for cookies
from django.core import signing
import json
from .populateCityTable import populateCityTable

def home_page(request):
    #render this specific request on the given template
    return render(request, 'home.html', {'loggedIn':False})

def make_report(request):
    #attempt cookie
    cookie=checkCookie(request)
    if cookie is not None:

        #grab all cities, crimes, and pass to report form

        return render(request, 'makereport.html', {'loggedIn':True})
    #if any steps fail, return forbidden
    return HttpResponse("AUTHENTICATION REQUIRED",status=401)

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
            response=HttpResponseRedirect(reverse('reportsite:report'))
            #https://stackoverflow.com/questions/3420122/filter-dict-to-contain-only-certain-keys
            #sign value with secret key using built in django encryption to save this dict for later
            value=signing.dumps({field:user[field] for field in ['role','id']})
            #save into cookie :)
            response.set_signed_cookie('reportsystem',value)
            return response
        #if user no exist, redirect back to page (TODO: add error message for login failure)
    except ValueError:
        pass
        #probably nothing sent, just gonna ignore that..
    return HttpResponseRedirect(reverse('reportsite:home'))

#check cookies, return cookie contents
def checkCookie(request):
    #attempt to grab cookie
    cookie=None
    try:
        cookie=request.get_signed_cookie('reportsystem')
    except:
        return None
    #load cookie to pass to templating and authenticate
    return signing.loads(cookie)
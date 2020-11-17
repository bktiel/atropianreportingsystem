from django.shortcuts import render
from django.views.decorators.http import require_http_methods

# Views go here. Sorta like routes in Flask

# Import models
from .models import *
from .populateCityTable import populateCityTable

def home_page(request):
    #render this specific request on the given template
    return render(request, 'home.html', {'loggedIn':False})

def make_report(request):
    #render this specific request on the given template
    return render(request, 'makereport.html', {'loggedIn':True})

@require_http_methods(["POST"])
def login(request):
    pass


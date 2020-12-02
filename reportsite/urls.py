#import all local views
from reportsite import views
from django.urls import path
app_name = 'reportsite'
#all the links and such
urlpatterns = [
    path('', views.home_page, name='home'),
    path('login', views.login, name='login'),
    path('report', views.make_report, name='report')
    ]
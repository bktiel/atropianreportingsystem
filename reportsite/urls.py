#import all local views
from reportsite import views
from django.urls import path
app_name = 'reportsite'
#all the links and such
urlpatterns = [
    path('', views.home_page, name='home'),
    path('login', views.login, name='login'),
    path('logout', views.logout, name='logout'),
    path('report', views.make_report, name='report'),
    path('receivereport', views.receive_report, name='receivereport'),
    path('reportreview', views.review_reports, name='reportreview'),
    path('cityreview', views.review_cities, name='cityreview'),
    path('updatecrimes', views.update_crimes, name='updatecrimes'),

    ]
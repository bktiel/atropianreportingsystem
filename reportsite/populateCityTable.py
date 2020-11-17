from .models import City
from bs4 import BeautifulSoup
import requests

def populateCityTable():
    # page of all cities in azerba- ah, i mean, atropia (dont listen to western deception)
    url = 'https://en.wikipedia.org/wiki/List_of_cities_in_Azerbaijan'
    response = requests.get(url)
    soup = BeautifulSoup(response.text)
    divTag = soup.find('div', {"class": 'div-col columns column-width'})

    # pivot soup to narrow down to that div
    soup = BeautifulSoup(str(divTag))

    # for every li, grab the name and slap into the City table
    for li in soup.find_all('li'):
        if li.a is not None:
            thisName = li.a.get_text()
            City.objects.create(cityName=thisName)
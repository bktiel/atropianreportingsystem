from .models import City, Citizen
from bs4 import BeautifulSoup
import requests
import itertools
import random
import bcrypt

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
            newcity=City(cityName=thisName)
            newcity.save()

#populateCityTable()

first=["Charlie","Finley","Skyler","Justice","Royal","Lennon","Oakley","Armani","Azariah","Landry","Frankie","Sidney","Denver","Robin","Campbel","Dominiq","Salem","Yael","Murphy","Jael","Ramsey","Hollis","Brighto","Perry","Gentry","Jaidyn","Reilly","Jules","Kylar","Austen","Ocean","Jackie","Storm","Honor","Ryley","Marlo","Nikita","Ridley","Indiana","Taylen","Clarke","Kylin","Eastyn","Payson","Amen","Timber","Cypress","Lake","Jaziah","Dakotah"]
def makeUsers():
    names=list(itertools.combinations(first,2))
    random.shuffle(names)
    for index,name in enumerate(names):
        try:
            newCitizen=Citizen()
            newCitizen.id=111023+index
            newCitizen.city=City.objects.get(pk=random.randrange(1,66))
            newCitizen.firstName=name[0]
            newCitizen.lastName=name[1]
            #https://pythonise.com/categories/python/python-password-hashing-bcrypt
            #pass must be in bytes before being processed by bcrypt
            password="password".encode('utf-8')
            salt = bcrypt.gensalt()
            hashed = bcrypt.hashpw(password, salt)
            #store hashed password, decode before committing to get string not pythonic text repr
            newCitizen.password=hashed.decode('utf-8')
            newCitizen.password="password"
            newCitizen.role=random.choice([0,0,0,0,1,1,1,2,2,3])
            newCitizen.save()
#makeUsers()

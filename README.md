# atropianreportingsystem
USMA IT393 Final Project

Django website with SQL backend. Employs modern templating and bootstrap, javascript.

To get up and running locally:

1) Install python if not already. In the root directory, run `pip install -r requirements.txt`. This will grab all required packages.
2) Create mySQL database 'reportsystem' and a new user 'atropia' with password 'glorytoatropia' (alternatively edit these settings in settings.py)
3) In root directory, run `python manage.py makemigrations` and then `python manage.py migrate`. This will commit the database structure to your local mysql instance.
4) Finally, run `python manage.py runserver`. Pages should be served at localhost:8000


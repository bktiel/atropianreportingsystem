from django.db import models

# Create your models here.
from django.utils.timezone import now


class City(models.Model):
    cityName=models.CharField(max_length=64)

class Crime(models.Model):
    crimeName=models.CharField(max_length=64)
    description=models.TextField(max_length=255)
    severity=models.PositiveSmallIntegerField()

class Citizen(models.Model):
    id=models.PositiveIntegerField(primary_key=True)
    city=models.ForeignKey(City, on_delete=models.CASCADE)
    firstName=models.CharField(max_length=32)
    lastName=models.CharField(max_length=32)
    password=models.CharField(max_length=64)
    role=models.PositiveSmallIntegerField()

class Report(models.Model):
    # reportID=models.IntegerField(primary_key=True)
    reportTime=models.DateTimeField(default=now)
    city=models.ForeignKey(City, on_delete=models.CASCADE)
    traitor=models.ForeignKey(Citizen, on_delete=models.CASCADE,related_name='+')
    patriot=models.ForeignKey(Citizen, on_delete=models.CASCADE,related_name='+')
    crimeName=models.ManyToManyField(Crime)
    priority=models.SmallIntegerField()
    remarks=models.TextField(max_length=255)

class Comment(models.Model):
    # commentID=models.IntegerField(primary_key=True)
    commentTime=models.DateTimeField(default=now)
    reportID=models.ForeignKey(Report, on_delete=models.CASCADE, default=None)
    informant=models.ForeignKey(Citizen, on_delete=models.CASCADE)
    priority=models.SmallIntegerField()
    content=models.TextField(max_length=255)

class InvestigationQueue(models.Model):
    reportID=models.ForeignKey(Report, on_delete=models.CASCADE)
    agentID=models.ForeignKey(Citizen, on_delete=models.CASCADE)
    priority=models.SmallIntegerField()

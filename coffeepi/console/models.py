from django.db import models

class Coffee(models.Model):
    upc = models.BigIntegerField()
    brand = models.CharField(max_length=255)
    type = models.CharField(max_length=255)
    roast = models.CharField(max_length=255)
    description = models.CharField(max_length=None)
    image = models.ImageField(upload_to='images')

    def __srt__(self):
        return self.type
from django.db import models

class Coffee(models.Model):
    upc = models.BigIntegerField()
    brand = models.CharField(max_length=255)
    type = models.CharField(max_length=255)
    roast = models.CharField(max_length=255)
    description = models.CharField(max_length=None)
    image = models.ImageField(upload_to='console/static/coffee_img')

    def __str__(self):
        return f"{self.brand} - {self.type}"
    
    @property
    def trimmed_image_url(self):
        if self.image:
            # Replace the 'console/static/' with '' in the URL
            return self.image.url.replace('console/static/', 'static/', 1)
        return None
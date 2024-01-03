from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("get_coffees_for_brand/", views.get_coffees_for_brand, name="get_coffees_for_brand"),
]
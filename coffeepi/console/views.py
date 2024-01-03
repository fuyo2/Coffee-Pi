from django.shortcuts import render
from django.db import connection  # Import Django's database connection
from django.http import JsonResponse
from .models import Coffee  # Import the Coffee model

def index(request):
    # Fetch data from the 'distinct_brands' view using raw SQL query
    with connection.cursor() as cursor:
        cursor.execute('SELECT brand FROM distinct_brands')
        brand_view = [row[0] for row in cursor.fetchall()]

    return render(request, 'home.html', {'brand_view': brand_view})

def get_coffees_for_brand(request):
    if request.method == 'GET':
        selected_brand = request.GET.get('brand_name')

        coffees = Coffee.objects.filter(brand=selected_brand)
        coffee_list = [
            {
                'type': coffee.type,
                'image': coffee.image.url,
                'trimmed_image_url': coffee.trimmed_image_url,
                'brand': coffee.brand,
                'description': coffee.description,
                'roast': coffee.roast
            }
            for coffee in coffees
        ]

        return JsonResponse({'coffees': coffee_list})
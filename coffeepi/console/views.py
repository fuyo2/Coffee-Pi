from django.shortcuts import render
from django.db import connection  # Import Django's database connection

def index(request):
    # Fetch data from the 'distinct_brands' view using raw SQL query
    with connection.cursor() as cursor:
        cursor.execute('SELECT brand FROM distinct_brands')
        brand_view = [row[0] for row in cursor.fetchall()]

    return render(request, 'home.html', {'brand_view': brand_view})
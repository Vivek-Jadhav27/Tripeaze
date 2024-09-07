from django.urls import path
from .views import itinerary_view, itinerary_api_view, index, show_trips_view, show_trips ,popular_hotels_view ,popular_places_view

urlpatterns = [
    path('', index, name='index'),
    path('api/', itinerary_api_view, name='itinerary_api'),
    path('trips/', show_trips, name='show_trips'),
    path('itinerary_view/', itinerary_view, name='itinerary_view'),
    path('show_trips_view/', show_trips_view, name='show_trips_view'),
    path('popular-hotels/', popular_hotels_view, name='popular_hotels'),
    path('popular_places_view/',popular_places_view,name='popular_places_view'),
]

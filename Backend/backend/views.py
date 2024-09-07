import random

import pandas as pd
from django.shortcuts import render
from .models import Hotel, Restaurant, Place, Trip
from .serializers import TripSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel


# Create your views here.
def generate_google_search_url(name, city):
    query = f"{name} {city}"
    return f"https://www.google.com/search?q={query.replace(' ', '+')}"

# Function to recommend hotels
def recommend_hotels(city, num_day, num_recommendations=5):
    city_hotels = Hotel.objects.filter(city__icontains=city)
    if not city_hotels.exists():
        return pd.DataFrame()

    hotel_df = pd.DataFrame(list(city_hotels.values()))
    hotel_df['combined_features'] = hotel_df['hotel_star_rating'].astype(str) + " " + hotel_df[
        'hotel_facilities'].astype(str)
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(hotel_df['combined_features'])
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)
    indices = pd.Series(hotel_df.index, index=hotel_df['property_name']).drop_duplicates()
    idx = random.choice(hotel_df.index)
    sim_scores = list(enumerate(cosine_sim[hotel_df.index.get_loc(idx)]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:num_recommendations + 1]
    hotel_indices = [i[0] for i in sim_scores]
    recommended_hotels = hotel_df.iloc[hotel_indices][
        ['property_name', 'hotel_star_rating', 'hotel_facilities', 'address', 'city', 'locality']]
    return recommended_hotels

# Function to recommend restaurants
def recommend_restaurants(city, num_day, num_recommendations=5):
    city_restaurants = Restaurant.objects.filter(location__icontains=city)
    if not city_restaurants.exists():
        return pd.DataFrame()

    restaurant_df = pd.DataFrame(list(city_restaurants.values()))
    restaurant_df['combined_features'] = restaurant_df['cuisine'].astype(str) + " " + restaurant_df['rating'].astype(
        str)
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(restaurant_df['combined_features'])
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)
    indices = pd.Series(restaurant_df.index, index=restaurant_df['restaurant_name']).drop_duplicates()
    idx = random.choice(restaurant_df.index)
    sim_scores = list(enumerate(cosine_sim[restaurant_df.index.get_loc(idx)]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:num_recommendations + 1]
    restaurant_indices = [i[0] for i in sim_scores]
    recommended_restaurants = restaurant_df.iloc[restaurant_indices][
        ['restaurant_name', 'cuisine', 'rating', 'average_price', 'area', 'location']]
    return recommended_restaurants

# Function to recommand places
def recommend_places(city, num_day, num_recommendations=5):
    city_places = Place.objects.filter(city__icontains=city)
    if not city_places.exists():
        return pd.DataFrame()

    place_df = pd.DataFrame(list(city_places.values()))
    place_df['combined_features'] = place_df['zone'].astype(str) + " " + place_df['state'].astype(str) + " " + place_df[
        'city'].astype(str)
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(place_df['combined_features'])
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)
    indices = pd.Series(place_df.index, index=place_df['name']).drop_duplicates()
    idx = random.choice(place_df.index)
    sim_scores = list(enumerate(cosine_sim[place_df.index.get_loc(idx)]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:num_recommendations + 1]
    place_indices = [i[0] for i in sim_scores]
    recommended_places = place_df.iloc[place_indices][
        ['zone', 'state', 'city', 'name', 'place_type', 'establishment_year', 'time_needed_to_visit',
         'google_review_rating', 'entrance_fee', 'airport_within_50km', 'weekly_off', 'significance', 'dslr_allowed',
         'number_of_google_reviews', 'best_time_to_visit','img_url','description']]
    return recommended_places

# Function to generate an itinerary
def generate_itinerary(city, num_days):
    itinerary = []
    hotels = recommend_hotels(city, num_days, num_recommendations=num_days)
    restaurants = recommend_restaurants(city, num_days, num_recommendations=num_days * 3)
    places = recommend_places(city, num_days, num_recommendations=num_days * 3)

    if hotels.empty or restaurants.empty or places.empty:
        return None

    for day in range(1, num_days + 1):
        hotel = hotels.iloc[day - 1] if day - 1 < len(hotels) else hotels.iloc[random.randint(0, len(hotels) - 1)]
        breakfast = restaurants.iloc[day * 3 - 3] if day * 3 - 3 < len(restaurants) else restaurants.iloc[
            random.randint(0, len(restaurants) - 1)]
        lunch = restaurants.iloc[day * 3 - 2] if day * 3 - 2 < len(restaurants) else restaurants.iloc[
            random.randint(0, len(restaurants) - 1)]
        dinner = restaurants.iloc[day * 3 - 1] if day * 3 - 1 < len(restaurants) else restaurants.iloc[
            random.randint(0, len(restaurants) - 1)]
        morning_activity = places.iloc[day * 3 - 3] if day * 3 - 3 < len(places) else places.iloc[
            random.randint(0, len(places) - 1)]
        afternoon_activity = places.iloc[day * 3 - 2] if day * 3 - 2 < len(places) else places.iloc[
            random.randint(0, len(places) - 1)]
        itinerary.append({
            'day': day,
            'hotel': {
                'property_name': hotel['property_name'],
                'hotel_star_rating': hotel['hotel_star_rating'],
                'address': hotel['address'],
                'hotel_facilities': hotel['hotel_facilities'],
                'city': hotel['city'],
                'locality':hotel['locality'],
                'url': generate_google_search_url(hotel['property_name'], city)
            },
            'breakfast': {
                'name': breakfast['restaurant_name'],
                'cuisine': breakfast['cuisine'],
                'rating': breakfast['rating'],
                'average_price': breakfast['average_price'],
                'location': breakfast['location'],
                'url': generate_google_search_url(breakfast['restaurant_name'], city)
            },
            'morning_activity': {
                'name': morning_activity['name'],
                'place_type': morning_activity['place_type'],
                'zone': morning_activity['zone'],
                'state': morning_activity['state'],
                'city': morning_activity['city'],
                'google_review_rating': morning_activity['google_review_rating'],
                'entrance_fee': morning_activity['entrance_fee'],
                'significance': morning_activity['significance'],
                'dslr_allowed': morning_activity['dslr_allowed'],
                'best_time_to_visit' : morning_activity['best_time_to_visit'],
                'img_url':morning_activity['img_url'],
                'description': morning_activity['description'],
                'url': generate_google_search_url(morning_activity['name'], city)

            },
            'lunch': {
                'name': lunch['restaurant_name'],
                'cuisine': lunch['cuisine'],
                'rating': lunch['rating'],
                'average_price': lunch['average_price'],
                'location': lunch['location'],
                'url': generate_google_search_url(lunch['restaurant_name'], city)
            },
            'afternoon_activity': {
                'name': afternoon_activity['name'],
                'place_type': afternoon_activity['place_type'],
                'zone': afternoon_activity['zone'],
                'state': afternoon_activity['state'],
                'city': afternoon_activity['city'],
                'google_review_rating': afternoon_activity['google_review_rating'],
                'entrance_fee': afternoon_activity['entrance_fee'],
                'significance': afternoon_activity['significance'],
                'dslr_allowed': afternoon_activity['dslr_allowed'],
                'best_time_to_visit': afternoon_activity['best_time_to_visit'],
                'img_url': afternoon_activity['img_url'],
                'description': afternoon_activity['description'],
                'url': generate_google_search_url(afternoon_activity['name'], city)
            },
            'dinner': {
                'name': dinner['restaurant_name'],
                'cuisine': dinner['cuisine'],
                'rating': dinner['rating'],
                'average_price': dinner['average_price'],
                'location': dinner['location'],
                'url': generate_google_search_url(dinner['restaurant_name'], city)
            }
        })
    return itinerary

def itinerary_view(request):
    if request.method == 'POST':
        city = request.POST.get('city')
        num_days = int(request.POST.get('num_days'))
        itinerary = generate_itinerary(city, num_days)
        if itinerary is None:
            return render(request, 'itinerary_error.html')
        trip = Trip(city=city, num_days=num_days, itinerary=itinerary)
        trip.save()
        return render(request, 'itinerary_result.html', {'itinerary': itinerary, 'city': city, 'num_days': num_days})
    return render(request, 'itinerary_form.html')

@api_view(['GET', 'POST'])
def itinerary_api_view(request):
    if request.method == 'POST':
        city = request.data.get('city')
        num_days = int(request.data.get('num_days'))
        itinerary = generate_itinerary(city, num_days)
        if itinerary is None:
            return Response({"error": "Unable to generate itinerary."}, status=400)

        trip = Trip(city=city, num_days=num_days, itinerary=itinerary)
        trip.save()

        return Response({'itinerary': itinerary, 'city': city, 'num_days': num_days})

    return Response({"message": "Send a POST request with city and num_days to generate an itinerary."})

@api_view(['GET'])
def show_trips(request):
    if request.method == 'GET':
        trips = Trip.objects.all()
        serializer = TripSerializer(trips, many=True)
        return Response(serializer.data, status=200)

@api_view(['GET'])
def index(request):
    if request.method == 'GET':
        return render(request, 'index.html')
    return Response('Method not allowed', status=405)

@api_view(['GET'])
def show_trips_view(request):
    trips = Trip.objects.all()
    serializer = TripSerializer(trips, many=True)
    return render(request, 'show_trips.html', {'trips': serializer.data})


# Function to fetch popular hotels
def fetch_popular_hotels(num_recommendations=15):
    popular_hotels = Hotel.objects.all().order_by('-hotel_star_rating')[:num_recommendations]
    if not popular_hotels:
        return pd.DataFrame()

    hotel_df = pd.DataFrame(list(popular_hotels.values()))
    hotel_df['combined_features'] = hotel_df['hotel_star_rating'].astype(str) + " " + hotel_df[
        'hotel_facilities'].astype(str)
    return hotel_df[['property_name', 'hotel_star_rating', 'hotel_facilities', 'address', 'city', 'locality']]

# Function to fetch popular places
def fetch_popular_places(num_recommendations=15):
    popular_places = Place.objects.all().order_by('-google_review_rating')[:num_recommendations]
    if not popular_places.exists():
        return pd.DataFrame()

    place_df = pd.DataFrame(list(popular_places.values()))
    place_df['combined_features'] = place_df['google_review_rating'].astype(str) + " " + place_df['number_of_google_reviews'].astype(str)
    return place_df[['zone', 'state', 'city', 'name', 'place_type', 'google_review_rating', 'entrance_fee','significance', 'best_time_to_visit', 'dslr_allowed','img_url', 'description']]


# View to display popular hotels
@api_view(['GET'])
def popular_hotels_view(request):
    num_recommendations = int(request.GET.get('num_recommendations', 20))
    popular_hotels_df = fetch_popular_hotels(num_recommendations=num_recommendations)

    if popular_hotels_df.empty:
        return Response({"error": "No popular hotels found."}, status=404)

    popular_hotels = popular_hotels_df.to_dict(orient='records')
    return Response({'popular_hotels': popular_hotels}, status=200)

# View to display popular places
@api_view(['GET'])
def popular_places_view(request):
    num_recommendations = int(request.GET.get('num_recommendations', 20))
    popular_places_df = fetch_popular_places(num_recommendations=num_recommendations)

    if popular_places_df.empty:
        return Response({"error": "No popular places found."}, status=404)

    popular_places = popular_places_df.to_dict(orient='records')
    return Response({'popular_places': popular_places}, status=200)

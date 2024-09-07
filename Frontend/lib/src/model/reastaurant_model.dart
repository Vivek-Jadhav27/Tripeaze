class Restaurant {
  final String name;
  final String cuisine;
  final String rating;
  final String averagePrice;
  final String location;
  final String url;

  Restaurant({
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.averagePrice,
    required this.location,
    required this.url,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'] ?? '',
      cuisine: json['cuisine'] ?? '',
      rating: json['rating'] ?? '',
      averagePrice: json['average_price'] ?? '',
      location: json['location'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cuisine': cuisine,
      'rating': rating,
      'average_price': averagePrice,
      'location': location,
      'url': url,
    };
  }
}

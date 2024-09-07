class Hotel {
  final String name;
  final String starRating;
  final String address;
  final String facilities;
  final String city;
  final String locality;
  final String url;

  Hotel({
    required this.name,
    required this.starRating,
    required this.address,
    required this.facilities,
    required this.city,
    required this.locality,
    required this.url
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['property_name'] ?? '',
      starRating: json['hotel_star_rating'] ?? '',
      address: json['address'] ?? '',
      facilities: json['hotel_facilities'] ?? '',
      city: json['city'] ?? '',
      locality: json['locality'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'star_rating': starRating,
      'address': address,
      'facilities': facilities,
      'city': city,
      'url': locality,
    };
  }
}

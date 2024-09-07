class Place {
  final String zone;
  final String state;
  final String city;
  final String name;
  final String placeType;
  final double googleReviewRating;
  final int entranceFee;
  final String bestTimeToVisit;
  final String imgUrl;
  final String description;
  final String url;

  Place({
    required this.zone,
    required this.state,
    required this.city,
    required this.name,
    required this.placeType,
    required this.googleReviewRating,
    required this.entranceFee,
    required this.bestTimeToVisit,
    required this.imgUrl,
    required this.description,
    required this.url
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      zone: json['zone'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      name: json['name'] ?? '',
      placeType: json['place_type'] ?? '',
      googleReviewRating: double.parse(json['google_review_rating']),
      entranceFee: int.parse(json['entrance_fee']),
      bestTimeToVisit: json['best_time_to_visit'] ?? '',
      imgUrl: json['img_url'] ?? '',
      description: json['description'] ?? '',
      url:  json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zone': zone,
      'state': state,
      'city': city,
      'name': name,
      'place_type': placeType,
      'google_review_rating': googleReviewRating.toString(),
      'entrance_fee': entranceFee.toString(),
      'best_time_to_visit': bestTimeToVisit,
      'img_url': imgUrl,
      'description': description,
    };
  }
}

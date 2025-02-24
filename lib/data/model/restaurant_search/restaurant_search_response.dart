import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';

class RestaurantSearchResponse {
  bool error;
  int founded;
  List<RestaurantList> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromRawJson(String str) =>
      RestaurantSearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantList>.from(
            json["restaurants"].map((x) => RestaurantList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

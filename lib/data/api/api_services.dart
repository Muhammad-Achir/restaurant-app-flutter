import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant_detail/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list/restaurant_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_search/restaurant_search_response.dart';

class ApiServices {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list!');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail!');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurantList(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list!');
    }
  }

  Future<List<CustomerReview>> addReview(
    String id,
    String name,
    String review,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/review'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "id": id,
          "name": name,
          "review": review,
        },
      ),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      List<CustomerReview> reviews =
          (data["customerReviews"] as List).map((item) {
        return CustomerReview.fromJson(item);
      }).toList();
      return reviews;
    } else {
      throw Exception("Error add review!");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/review_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(
    BuildContext context,
    String id,
  ) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState();
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);

        final reviewProvider =
            // ignore: use_build_context_synchronously
            Provider.of<ReviewProvider>(context, listen: false);
        reviewProvider.reviews = result.restaurant.customerReviews;
        notifyListeners();
      }
    } on Exception {
      _resultState = RestaurantDetailErrorState();
      notifyListeners();
    }
  }
}

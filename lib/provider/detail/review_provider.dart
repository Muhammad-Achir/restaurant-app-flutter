import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_detail/customer_review.dart';
import 'package:restaurant_app/static/review_result_state.dart';

class ReviewProvider extends ChangeNotifier {
  final List<CustomerReview> _reviews = [];

  final ApiServices _apiServices;

  ReviewProvider(this._apiServices);

  ReviewResultState _resultState = ReviewLoadedState();

  ReviewResultState get resultState => _resultState;
  List<CustomerReview> get reviews => _reviews;

  set resultState(ReviewResultState value) {
    _resultState = value;
    notifyListeners();
  }

  Future<void> addReview(String id, String name, String review) async {
    try {
      _resultState = ReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.addReview(id, name, review);
      if (result.isEmpty) {
        _resultState = ReviewErrorState();
        notifyListeners();
      } else {
        _resultState = ReviewLoadedState();
        reviews = result;
        notifyListeners();
      }
    } on Exception {
      _resultState = ReviewErrorState();
      notifyListeners();
    }
  }

  set reviews(List<CustomerReview> values) {
    _reviews.clear();
    _reviews.addAll(values);
    notifyListeners();
  }
}

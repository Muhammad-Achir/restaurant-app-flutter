import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchNoneState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<RestaurantList> data;

  RestaurantSearchLoadedState(this.data);
}

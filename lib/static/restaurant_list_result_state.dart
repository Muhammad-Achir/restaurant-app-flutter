import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';

sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {}

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<RestaurantList> data;
  RestaurantListLoadedState(this.data);
}

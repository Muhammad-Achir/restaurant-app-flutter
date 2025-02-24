import 'package:flutter/material.dart';
import 'package:restaurant_app/data/database/database_favorite_service.dart';
import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';

class DatabaseFavoriteProvider extends ChangeNotifier {
  final DatabaseFavoriteService _service;

  DatabaseFavoriteProvider(this._service);

  String _message = "";
  String get message => _message;

  List<RestaurantList>? _restaurantList;

  List<RestaurantList>? get restaurantList => _restaurantList;

  RestaurantList? _restaurant;
  RestaurantList? get restaurant => _restaurant;

  Future<void> saveRestaurant(RestaurantList value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = 'Failed to save your data';
      } else {
        _message = 'Your data is saved';
      }
    } catch (e) {
      _message = 'Has error when save data';
    }
    notifyListeners();
  }

  Future<void> getAllRestaurant() async {
    try {
      _restaurantList = await _service.getAllItems();
      _message = 'Loaded datas';
    } catch (e) {
      _message = 'Failed to load datas';
    }
    notifyListeners();
  }

  Future getRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = 'Success get data';
    } catch (e) {
      _message = 'Failed get data';
    }
    notifyListeners();
  }

  Future removeRestaurant(String id) async {
    try {
      await _service.removeItem(id);
      _message = 'Deleted data';
    } catch (e) {
      _message = 'Failed delete data';
    }
    notifyListeners();
  }
}

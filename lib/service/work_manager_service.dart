import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';
import 'package:restaurant_app/service/http_service.dart';
import 'package:restaurant_app/service/local_notification_service.dart';
import 'package:restaurant_app/static/my_workmanager.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print(task);
    debugPrint("WorkManager Task Triggered: $task"); // Logging task

    if (task == "initialTask") {
      WorkManagerService().scheduleDailyTaskAt11();
    }

    final HttpService httpService = HttpService();
    final localNotificationService = LocalNotificationService(httpService);
    try {
      final apiService = ApiServices();
      final result = await apiService.getRestaurantList();

      final random = Random();
      int randomNumber = random.nextInt(result.restaurants.length);

      final RestaurantList restaurant = result.restaurants[randomNumber];

      await localNotificationService.showBigPictureNotification(
        id: int.parse(restaurant.pictureId),
        title: restaurant.name,
        body: restaurant.description,
        payload: restaurant.id,
      );
      return Future.value(true);
    } catch (e) {
      localNotificationService.showNotification(
        id: 1,
        title: 'It\'s chow Time',
        body: 'Get some for Lunch',
        payload: '',
      );
      return Future.value(false);
    }
  });
}

class WorkManagerService {
  final Workmanager _workmanager;

  WorkManagerService([Workmanager? workmanager])
    : _workmanager = workmanager ??= Workmanager();

  Future init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  void scheduleInitialTaskAt11() {
    final now = DateTime.now();

    final scheduledTime = DateTime(now.year, now.month, now.day, 11);

    var initialDelay = scheduledTime.difference(now);

    if (initialDelay.isNegative) {
      scheduledTime.add(Duration(days: 1));
      initialDelay = scheduledTime.difference(now);
    }

    Workmanager().registerOneOffTask(
      "initialTask",
      "initialTask",
      initialDelay: initialDelay,
      inputData: <String, dynamic>{'oneTask': 'oneTask running'},
    );
  }

  void scheduleDailyTaskAt11() {
    Workmanager().registerPeriodicTask(
      MyWorkmanager.periodic.uniqueName,
      MyWorkmanager.periodic.taskName,
      frequency: Duration(hours: 24), 
      inputData: <String, dynamic>{'periodicTask': 'periodicTask running'},
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
    print("All tasks cancelled");
  }
}

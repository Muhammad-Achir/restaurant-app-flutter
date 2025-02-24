import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/restaurant_app.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'robot/evaluate_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();

  String route = NavigationRoute.mainRoute.name;

  String? payload;

  testWidgets('integrate search item feature', (tester) async {
    final evaluateRobot = EvaluateRobot(tester);

    // load ui
    await evaluateRobot.loadUI(
      RestaurantApp(
        payload: payload,
        pref: pref,
        route: route,
      ),
    );

    // search restaurant
    await evaluateRobot.tapSearchButton();
    await evaluateRobot.typeSearch('cafe');
    await evaluateRobot.checkSearchResult();
  });
}

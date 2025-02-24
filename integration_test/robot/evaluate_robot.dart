import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class EvaluateRobot {
  final WidgetTester tester;

  const EvaluateRobot(this.tester);

  final searchButtonKey = const ValueKey('searchButton');
  final searchFieldKey = const ValueKey('searchField');
  final searchSubmitKey = const ValueKey('searchSubmit');

  Future loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    // await Future.delayed(Duration(seconds: 5));
  }

  Future tapSearchButton() async {
    final searchButtonFinder = find.byKey(searchButtonKey);
    await tester.tap(searchButtonFinder);
    await tester.pumpAndSettle();
  }

  Future typeSearch(String search) async {
    final searchFieldFinder = find.byKey(searchFieldKey);
    await tester.tap(searchFieldFinder);
    await tester.enterText(searchFieldFinder, search);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future checkSearchResult() async {
    final providerFinder = find.byType(Consumer<RestaurantSearchProvider>);
    expect(providerFinder, findsOneWidget);

    final provider = Provider.of<RestaurantSearchProvider>(
      tester.element(providerFinder),
      listen: false,
    );

    expect(provider.resultState, isA<RestaurantSearchLoadedState>());
    expect(
        (provider.resultState as RestaurantSearchLoadedState).data.isNotEmpty,
        true);
  }
}

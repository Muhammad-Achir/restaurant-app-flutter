import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/screen/home/home_app_bar.dart';

void main() {
  late Widget widget;

  setUp(() {
    widget = MaterialApp(
      home: CustomScrollView(
        slivers: [
          HomeAppBar(),
        ],
      ),
    );
  });

  testWidgets('have component sliver app bar and title', (tester) async {
    await tester.pumpWidget(widget);

    final appBarFinder = find.byType(SliverAppBar);
    final textInAppBarFinder = find.descendant(
      of: appBarFinder,
      matching: find.byType(Text).first,
    );
    final textInAppBar = tester.widget<Text>(textInAppBarFinder);

    expect(appBarFinder, findsOneWidget);
    expect(textInAppBar.data, 'Restaurant List');
  });
}

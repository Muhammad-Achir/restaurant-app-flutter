import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/database/database_favorite_service.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/detail/review_provider.dart';
import 'package:restaurant_app/provider/favorite/database_favorite_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/nav_provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/notification/payload_provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/provider/setting/share_preferences_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/navigation_screen.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/service/http_service.dart';
import 'package:restaurant_app/service/local_notification_service.dart';
import 'package:restaurant_app/service/shared_preferences_service.dart';
import 'package:restaurant_app/service/work_manager_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({
    super.key,
    required this.payload,
    required this.pref,
    required this.route,
  });

  final String? payload;
  final SharedPreferences pref;
  final String route;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PayloadProvider(
              payload: payload,
            ),
          ),
          Provider(create: (context) => HttpService()),
          Provider(create: (context) => ApiServices()),
          Provider(create: (context) => DatabaseFavoriteService()),
          Provider(create: (context) => SharedPreferencesService(pref)),
          Provider(
            create: (context) => LocalNotificationService(
              context.read<HttpService>(),
            )
              ..init()
              ..configureLocalTimeZone(),
          ),
          Provider(create: (context) => WorkManagerService()..init()),
          ChangeNotifierProvider(
            create: (context) => RestaurantListProvider(
              context.read<ApiServices>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantDetailProvider(
              context.read<ApiServices>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => ReviewProvider(
              context.read<ApiServices>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantSearchProvider(
              context.read<ApiServices>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => NavProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoriteIconProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DatabaseFavoriteProvider(
              context.read<DatabaseFavoriteService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => SharePreferencesProvider(
              context.read<SharedPreferencesService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => LocalNotificationProvider(
              context.read<LocalNotificationService>(),
            )..requestPermissions(),
          ),
        ],
        child: RestaurantAppView(
          initialRoute: route,
        ));
  }
}

class RestaurantAppView extends StatefulWidget {
  final String initialRoute;
  const RestaurantAppView({
    super.key,
    required this.initialRoute,
  });

  @override
  State<RestaurantAppView> createState() => _RestaurantAppViewState();
}

class _RestaurantAppViewState extends State<RestaurantAppView> {
  @override
  void initState() {
    super.initState();

    final sharePreferenceProvider = context.read<SharePreferencesProvider>();

    Future.microtask(() async {
      await sharePreferenceProvider.getThemeValue();
      await sharePreferenceProvider.getLunchReminder();
    });
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    didReceiveLocalNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: context.watch<SharePreferencesProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: widget.initialRoute,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const NavigationScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        NavigationRoute.searchRoute.name: (context) => SearchScreen(),
      },
    );
  }
}

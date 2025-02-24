import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/notification/received_notification.dart';
import 'package:restaurant_app/provider/nav_provider.dart';
import 'package:restaurant_app/provider/notification/payload_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';
import 'package:restaurant_app/service/local_notification_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) {
      print('select notif $payload');
      context.read<PayloadProvider>().payload = payload;
      print('select notif 2 $payload');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushNamed(
            context,
            NavigationRoute.detailRoute.name,
            arguments: payload,
          );
        }
      });
      print('select notif 3 $payload');
    });
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) {
      final payload = receivedNotification.payload;
      print('did receive notif $payload');
      context.read<PayloadProvider>().payload = payload;
      Navigator.pushNamed(
        context,
        NavigationRoute.detailRoute.name,
        arguments: payload,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _configureSelectNotificationSubject();
    _configureDidReceiveLocalNotificationSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const FavoriteScreen(),
            _ => const SettingScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<NavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<NavProvider>().setIndexBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            tooltip: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            tooltip: 'Setting',
          ),
        ],
      ),
    );
  }
}

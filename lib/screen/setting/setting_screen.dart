import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/setting/share_preferences_provider.dart';
import 'package:restaurant_app/service/work_manager_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();

    final sharePreferenceProvider = context.read<SharePreferencesProvider>();
    final localNotificationProvider = context.read<LocalNotificationProvider>();

    Future.microtask(() async {
      await sharePreferenceProvider.getThemeValue();
      await localNotificationProvider.getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark Mode'),
              Consumer<SharePreferencesProvider>(
                  builder: (context, value, child) {
                return Switch(
                  value: value.isDarkMode,
                  onChanged: saveTheme,
                );
              }),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Remind Lunch at 11.00 AM'),
              Consumer<SharePreferencesProvider>(
                  builder: (context, value, child) {
                return Switch(
                  value: value.isLunchReminder,
                  onChanged: reminderLunch,
                );
              }),
              // Switch(
              //   value: context.watch<LocalNotificationProvider>().isScheduled!,
              //   onChanged: reminderLunch,
              // ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  void saveTheme(bool value) async {
    final sharePreferencesProvider = context.read<SharePreferencesProvider>();
    sharePreferencesProvider.saveThemeValue(value);
  }

  void reminderLunch(bool value) {
    final sharePreferencesProvider = context.read<SharePreferencesProvider>();
    sharePreferencesProvider.saveLunchReminderValue(value);

    // final localNotificationProvider = context.read<LocalNotificationProvider>();
    final workManagerService = context.read<WorkManagerService>();

    if (value) {
      // localNotificationProvider
      //   ..showNotification()
      //   ..showBigPictureNotification()
      // ..scheduleDailyLunchNotification()
      // ..getNotification();

      workManagerService.scheduleInitialTaskAt11();
    } else {
      // localNotificationProvider
      //   ..cancelNotification()
      //   ..getNotification();

      workManagerService.cancelAllTask();
    }
  }
}

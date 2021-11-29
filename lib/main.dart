import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/ui/details/detail_page.dart';
import 'package:restaurant_api/ui/favorite_page.dart';
import 'package:restaurant_api/ui/home/home_page.dart';
import 'package:restaurant_api/ui/home/search_bar.dart';
import 'package:restaurant_api/ui/setting_page.dart';
import 'package:restaurant_api/ui/splash_screen.dart';
import 'package:restaurant_api/utils/background_service.dart';
import 'package:restaurant_api/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database/database_helper.dart';
import 'data/preferences/preferences_helper.dart';
import 'data/provider/preferences_provider.dart';
import 'data/provider/restaurant_favorite_provider.dart';
import 'data/provider/restaurant_provider.dart';
import 'data/provider/scheduling_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(context),
        ),
        ChangeNotifierProvider<RestaurantFavoriteProvider>(
          create: (_) => RestaurantFavoriteProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant Api',
        theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SearchBar.routeName: (context) => SearchBar(),
          DetailPage.routeName: (context) =>
              DetailPage(id: ModalRoute.of(context).settings.arguments),
          SplashScreen.routeName: (context) => SplashScreen(),
          FavoritePage.routeName: (contex) => const FavoritePage(),
          SettingPage.routeName: (context) => const SettingPage()
        },
      ),
    );
  }
}

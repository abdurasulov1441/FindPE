import 'package:easy_localization/easy_localization.dart';
import 'package:find_pe/app/app.dart';
import 'package:find_pe/common/db/cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    
  const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitSettings);
      
  WidgetsFlutterBinding.ensureInitialized();
  await cache.init();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase yuklashda xatolik: $e");
  }
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  EasyLocalization.logger.enableBuildModes = [];
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
     supportedLocales: const [
        Locale('ru'), 
        Locale('en'), 
        Locale('zh'), 
        Locale('ar'),
        Locale('de'),
      ],
      startLocale: const Locale('ru'),
      child:  App(),
      ),
    
  );
}

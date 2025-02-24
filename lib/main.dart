import 'package:easy_localization/easy_localization.dart';
import 'package:find_pe/app/app.dart';
import 'package:find_pe/common/db/cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await cache.init();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase yuklashda xatolik: $e");
  }

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
        Locale('uz'),
        Locale('ru'),
        Locale('uk'),
      ],
      startLocale: const Locale('uz'),
      child:  App(),
      ),
    
  );
}

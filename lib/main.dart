import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remender_new/splash/splash_screen.dart';

import 'create_schedule/helper/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
  ));
}

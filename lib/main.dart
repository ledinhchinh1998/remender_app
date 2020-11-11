import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remender_new/splash/splash_screen.dart';

import 'helper/db_helper.dart';
import 'helper/my_list_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await MLDBHelper.initDb();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
  ));
}

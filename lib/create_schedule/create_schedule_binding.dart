import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'create_schedule_controller.dart';

class CreateScheduleBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<CreateScheduleController>(() => CreateScheduleController());
  }

}
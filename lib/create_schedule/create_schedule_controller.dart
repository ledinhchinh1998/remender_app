import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'component/detail_schedule.dart';
import 'models/schedule_model.dart';

class CreateScheduleController extends GetxController {
  var isAddSchedule = false.obs;
  var listSchedule = List<ScheduleModel>().obs;
  FocusNode focusNode = FocusNode();
  String currentTitleItem = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addSchedule() {
    ScheduleModel schedule = ScheduleModel(isScheduled: true, title: "", dateTime: DateTime.now(), focusNode: FocusNode());
    listSchedule.value.add(schedule);
    update();
  }

  void checkScheduleEmpty() {
    isAddSchedule.value = false;
    if (listSchedule[listSchedule.length - 1].title == "") {
      listSchedule.value.removeAt(listSchedule.length - 1);
      update();
    } else {
      update();
      return;
    }
  }

  void onchangeTextTitle(value) {
    listSchedule[listSchedule.length - 1].title = value;
  }

  void onSubmittedTextTitle(value) {
    listSchedule[listSchedule.length - 1].title = value;
  }

  void onPressedInfo(index) {
    Get.bottomSheet(DetailScheduleScreen(index: index));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("vao day");
  }
}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:remender_new/create_schedule/create_schedule_binding.dart';
import 'package:remender_new/create_schedule/create_schedule_screen.dart';

import 'model/calendar_model.dart';

class HomeController extends GetxController {
  FocusNode focusNode = FocusNode();
  TextEditingController textController = TextEditingController();
  var isEmpty = true.obs;
  var isFocusSearchBar = false.obs;
  List<CalendarModel> calendars;
  List<CalendarModel> calendarFilterd;

  @override
  void onInit() {
    // TODO: implement onInit
    focusNode.addListener(onFocusChange);
    super.onInit();
  }

  void pushToCreateSchedule() {
    Get.to(CreateScheduleScreen(),binding: CreateScheduleBinding());
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      isFocusSearchBar.value = true;
    } else {
      isFocusSearchBar.value = false;
    }
    update();
  }

  void onTextChange(String value) {
    if (value == "") {
      isEmpty.value = true;
    } else {
      isEmpty.value = false;
    }
  }

  void filterdSearchResult(String query) {
    if (query.isEmpty) {
      return;
    } else {
      calendarFilterd.clear();
      calendars.forEach((element) {
        if (element.title.toLowerCase().contains(query)) {
          calendarFilterd.add(element);
        }
      });
    }
  }


}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:remender_new/create_schedule/create_schedule_binding.dart';
import 'package:remender_new/create_schedule/create_schedule_screen.dart';
import 'package:remender_new/helper/my_list_helper.dart';
import 'package:remender_new/home/model/list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/calendar_model.dart';

class HomeController extends GetxController {
  FocusNode focusNode = FocusNode();
  TextEditingController textController = TextEditingController();
  var isEmpty = true.obs;
  var isFocusSearchBar = false.obs;
  var calendars = List<ListModel>().obs;
  var calendarFilterd = List<ListModel>().obs;
  var countToday = 0.obs;
  var countSchedule = 0.obs;
  SharedPreferences prefs;

  @override
  void onInit() async {
    getMyList();
    prefs = await SharedPreferences.getInstance();
    countToday.value = (prefs.getInt('counterToday') ?? 0);
    focusNode.addListener(onFocusChange);
    super.onInit();
  }

  void pushToCreateSchedule() async {
   var result = await Get.to(CreateScheduleScreen(title: 'Today',),binding: CreateScheduleBinding());
   await prefs.setInt('counterToday', result);
   countToday.value = result;
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
      calendarFilterd.value.clear();
      calendars.value.forEach((element) {
        if (element.title.toLowerCase().contains(query)) {
          calendarFilterd.value.add(element);
        }
      });
    }
  }

  //
  void getMyList() async {
    List<Map<String, dynamic>> noteList = await MLDBHelper.query();
    calendars.value = noteList.map((data) => ListModel.fromMap(data)).toList();
  }

  Future<void> addNote(ListModel listModel) async {
    await MLDBHelper.insert(listModel);
  }


}
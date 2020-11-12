import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'component/detail_schedule.dart';
import '../helper/db_helper.dart';
import 'models/schedule_model.dart';


import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import '../main.dart';

class CreateScheduleController extends GetxController {
  var isAddSchedule = false.obs;
  var listSchedule = List<ScheduleModel>().obs;
  FocusNode focusNode = FocusNode();
  String currentTitleItem = "";
  TextEditingController controller = TextEditingController();
  var isCheckBox = false.obs;

  void setCheckBox(ScheduleModel scheduleModel){
    if (scheduleModel.isScheduled == 0) {
      scheduleModel.isScheduled = 1;
    }  else {
      scheduleModel.isScheduled = 0;
    }
    updateNotes(scheduleModel);
  }

  @override
  void onReady() {
    super.onReady();
    getNotes();
  }

  @override
  void onInit() async {
    await _configureLocalTimeZone();
    super.onInit();
  }

  int result(){
    int count = 0;
    listSchedule.value.forEach((element) {
      if (element.isScheduled == 0) {
        count ++;
      }
    });
    return count;
  }

  void addSchedule() {
    ScheduleModel schedule = ScheduleModel(
        isScheduled: 0,
        title: currentTitleItem ?? "",
        dateTime: DateTime.now().toString(),
        note: '',
        focusNode: null);
    listSchedule.value.add(schedule);
    update();
  }
  void deleteNote(ScheduleModel noteModel) async {
    await DBHelper.delete(noteModel);
    getNotes();
  }

  void updateNotes(ScheduleModel noteModel) async {
    await DBHelper.update(noteModel);
    update();
    getNotes();
  }

  void getNotes() async {
    List<Map<String, dynamic>> noteList = await DBHelper.query();
    listSchedule.value = noteList.map((data) => ScheduleModel.fromJson(data)).toList();
  }

  void checkScheduleEmpty() {
    isAddSchedule.value = false;
    if (listSchedule[listSchedule.length - 1].title == "") {
      deleteNote(listSchedule[listSchedule.length - 1]);
      listSchedule.value.removeAt(listSchedule.length - 1);
      update();
    } else {
      var scheduleModel = listSchedule[listSchedule.length - 1];
      var schedule = ScheduleModel(
          isScheduled: scheduleModel.isScheduled,
          title: currentTitleItem,
          momentOfReminding: scheduleModel.momentOfReminding,
          dateTime: scheduleModel.dateTime,
          note: scheduleModel.note);
      addNote(schedule);
      update();
      return;
    }
  }

  Future<void> addNote(ScheduleModel scheduleModel) async {
    await DBHelper.insert(scheduleModel);
  }

  void onchangeTextTitle(value) {
    listSchedule[listSchedule.length - 1].title = value;
    currentTitleItem = value;
  }

  void onSubmittedTextTitle(value) {
    listSchedule[listSchedule.length - 1].title = value;
    currentTitleItem = value;
  }

  void onPressedInfo(index) {
    Get.bottomSheet(DetailScheduleScreen(index: index));
  }

  // push notification

  Future<void> zonedScheduleNotification({int year, int month,int day,int hour,int minute,String title,String body,}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        _nextInstanceOfTenAM(year: year,month: month,day: day,hour: hour,minute: minute),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
  tz.TZDateTime _nextInstanceOfTenAM({int year, int month,int day,int hour,int minute}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, year,month, day, hour,minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await platform.invokeMethod('getTimeZoneName');
    print(timeZoneName);
    tz.setLocalLocation(tz.getLocation(timeZoneName.toString()));
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

}

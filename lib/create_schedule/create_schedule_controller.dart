import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'component/detail_schedule.dart';
import 'helper/db_helper.dart';
import 'models/schedule_model.dart';
import 'models/schedule_model.dart';
import 'models/schedule_model.dart';
import 'models/schedule_model.dart';
import 'models/schedule_model.dart';
import 'models/schedule_model.dart';

class CreateScheduleController extends GetxController {
  var isAddSchedule = false.obs;
  var listSchedule = List<ScheduleModel>().obs;
  FocusNode focusNode = FocusNode();
  String currentTitleItem = "";
  TextEditingController controller = TextEditingController();
  var isCheckBox = false.obs;

  void setCheckBox(ScheduleModel scheduleModel){

    print('alooooo  =  ${scheduleModel.toJson()}');

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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addSchedule() {
    ScheduleModel schedule = ScheduleModel(
        isScheduled: 0,
        title: currentTitleItem ?? "",
        dateTime: DateTime.now().toString(),
        note: '',
        focusNode: FocusNode());
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
    listSchedule.value = noteList.map((data) => new ScheduleModel.fromJson(data)).toList();
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("vao day");
  }
}

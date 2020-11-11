
import 'package:flutter/cupertino.dart';

class ScheduleModel {
  bool isScheduled;
  String title;
  String momentOfReminding;
  FocusNode focusNode;
  DateTime dateTime;
  String note;

  ScheduleModel({this.isScheduled, this.title, this.momentOfReminding, this.focusNode, this.note, this.dateTime});
}
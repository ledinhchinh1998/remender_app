
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'component/schedule_item.dart';
import 'create_schedule_controller.dart';

class CreateScheduleScreen extends GetView<CreateScheduleController> {

  Widget rightButtonBar() {
    return FlatButton(
      onPressed: () {
        controller.checkScheduleEmpty();
      },
      child: Text(
        "Done",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 18
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateScheduleController>(
      init: CreateScheduleController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
              leadingWidth: 100,
              backgroundColor: Colors.black87,
              automaticallyImplyLeading: false,
              actions: [
                _.isAddSchedule.value ? rightButtonBar() : Text("")
              ],
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: Colors.blue),
                      Text(
                        "List",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              _.isAddSchedule.value = true;
              _.addSchedule();
              print(_.listSchedule.length);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                FocusScope.of(context).requestFocus(_.listSchedule.value[_.listSchedule.length - 1].focusNode);
              });
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Icon(Icons.add, color: Colors.black87, size: 25),
                ),
                SizedBox(width: 10),
                Text(
                  "New Schedule",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: _.listSchedule.value.length == 0 ? Container() : GestureDetector(
            onTap: () {
              controller.checkScheduleEmpty();
              controller.isAddSchedule.value = false;
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                var schedule = _.listSchedule[index];
                return ScheduleItem(isChecked: schedule.isScheduled, title: schedule.title, momentSchedule: DateFormat.yMMMd().add_jm().format(schedule.dateTime), focusNode: schedule.focusNode, onchange: (value) => _.onchangeTextTitle(value), onPressedInfo: () => _.onPressedInfo(index));
              },
              itemCount: _.listSchedule.value.length,
            ),
          ),
        );
      },
    );
  }
}

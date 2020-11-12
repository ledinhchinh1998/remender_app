import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:remender_new/create_schedule/create_schedule_binding.dart';
import 'package:remender_new/create_schedule/create_schedule_screen.dart';
import 'package:remender_new/home/home_controller.dart';
import 'package:remender_new/home/model/calendar_model.dart';
import 'package:remender_new/home/model/list_model.dart';
import '../home_screen.dart';

class SectionMyListCalendar extends StatelessWidget {
  final List<ListModel> calendars;

  SectionMyListCalendar({this.calendars});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My List",
          style: styleCountScheduler,
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(10),
          decoration: decorationContainer,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: calendars.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                var item = calendars[index];
                var arr =
                    item.color.split(':')[1].split('(0x')[1].split(')')[0];
                int value = int.parse(arr, radix: 16);
                Color otherColor = new Color(value);
                return ItemCalendar(
                    colorIcon: otherColor, title: item.title, count: 1);
              }),
        )
      ],
    );
  }
}

class ItemCalendar extends StatelessWidget {
  final Color colorIcon;
  final String title;
  final int count;
  final Function deleteNote;

  ItemCalendar({this.colorIcon, this.title, this.count, this.deleteNote});

  Widget myListNote() {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: InkWell(
          onTap: () => Get.to(
              CreateScheduleScreen(
                title: title,
              ),
              binding: CreateScheduleBinding()),
          child: Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: colorIcon,
                          borderRadius: BorderRadius.circular(25)),
                      child: Icon(
                        Icons.list,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: deleteNote,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return myListNote();
  }
}

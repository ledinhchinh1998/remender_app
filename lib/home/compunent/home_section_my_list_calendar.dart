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

  Color colorBg = Colors.lightBlue;
  List<Color> listColor = [
    Colors.deepOrange,
    Colors.amber,
    Colors.amberAccent,
    Colors.green,
    Colors.lightBlue,
    Colors.deepPurpleAccent,
    Colors.brown
  ];

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
                    updateNode: () {
                      Get.bottomSheet(Container(
                        color: Colors.black87,
                        child: Container(
                          child: ListView(
                            children: [
                              AppBar(
                                title: Text(item.title ?? ''),
                                actions: [
                                  FlatButton(child: Text('Done'),onPressed: (){},)
                                ],
                              ),
                              CircleAvatar(
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.list,
                                    size: 50,
                                    color: Colors.white,),
                                ),
                              ),
                              SizedBox(height: 20),

                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                    textAlign: TextAlign.center,
//                                  controller: textEditingController,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    decoration: InputDecoration(border: InputBorder.none)),
                              ),
                              SizedBox(height: 20),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: listColor
                                    .map((item) => GestureDetector(
                                  onTap: () {
                                    colorBg = item;
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: item,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(25)),
                                  ),
                                ))
                                    .toList()
                                    .cast<Widget>(),
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    deleteNote: () {
                      controller.deleteNote(item);
                      controller.update();
                    },
                    colorIcon: otherColor,
                    title: item.title,
                    count: 1);
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
  final Function updateNode;

  ItemCalendar(
      {this.colorIcon,
      this.title,
      this.count,
      this.deleteNote,
      this.updateNode});

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
        IconSlideAction(
          caption: 'Update',
          color: Colors.blue,
          icon: Icons.system_update_alt_sharp,
          onTap: updateNode,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return myListNote();
  }
}

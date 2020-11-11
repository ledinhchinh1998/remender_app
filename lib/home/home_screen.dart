import 'dart:ffi';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'compunent/create_list.dart';
import 'compunent/home_search_bar.dart';
import 'compunent/home_section_all_calendar.dart';
import 'compunent/home_section_calendar.dart';
import 'compunent/home_section_my_list_calendar.dart';
import 'home_controller.dart';

final TextStyle styleTitleHome =
    TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold);

final TextStyle styleCountScheduler =
    TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold);

final BoxDecoration decorationContainer = BoxDecoration(
  color: Colors.grey[800],
  borderRadius: BorderRadius.circular(12),
);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());
  int countToday = 0;
  int countSchedule = 0;

  Widget test() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 9,
                child: GestureDetector(
                    onTap: () {
                      controller.pushToCreateSchedule();
                    },
                    child: SectionCalender(
                        imgPath: "assets/calendar.png",
                        title: "Today",
                        count: controller.countToday.value,
                        color: Colors.blue))),
            SizedBox(width: 20),
            Flexible(
                flex: 9,
                child: SectionCalender(
                    imgPath: "assets/clock.png",
                    title: "Scheduled",
                    count: countSchedule,
                    color: Colors.amberAccent))
          ],
        ),
        SizedBox(height: 20),
        SectionAllCalendar(title: "All", count: 1),
        SizedBox(height: 30),
        SectionMyListCalendar(calendars: controller.calendars.value,)
      ],
    );
  }

  Widget listSearch() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Icon(Icons.height);
      },
      itemCount: 1,
    );
  }

  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black87,
      actions: [
        FlatButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black87,
          appBar: _.focusNode.hasFocus ? null : appBar(),
          floatingActionButton: GestureDetector(
              onTap: () =>
                  Get.bottomSheet(CreateListScreen(), isScrollControlled: true,ignoreSafeArea: false),
              child: Text("Add list",
                  style: TextStyle(color: Colors.blue, fontSize: 18))),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: _.focusNode.hasFocus ? 20 : 0),
                SearchBar(
                    controller: _.textController,
                    onTextChange: (x) => _.onTextChange(x),
                    nodeFocus: _.focusNode),
                SizedBox(height: 20),
                Obx(() {
                  return controller.isEmpty.value ? test() : listSearch();
                })
              ],
            ),
          ),
        );
      },
    );
  }
}

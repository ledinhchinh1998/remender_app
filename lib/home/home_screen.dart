import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:remender_new/create_schedule/create_schedule_screen.dart';
import '../main.dart';
import 'compunent/create_list.dart';
import 'compunent/home_search_bar.dart';
import 'compunent/home_section_all_calendar.dart';
import 'compunent/home_section_calendar.dart';
import 'compunent/home_section_my_list_calendar.dart';
import 'home_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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


  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        CreateScheduleScreen(),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

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
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black87,
            //appBar: _.focusNode.hasFocus ? null : appBar(),
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
          ),
        );
      },
    );
  }
}

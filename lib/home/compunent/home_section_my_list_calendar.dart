import 'package:flutter/material.dart';
import 'package:remender_new/home/model/calendar_model.dart';
import '../home_screen.dart';

class SectionMyListCalendar extends StatelessWidget {

  final List<CalendarModel> calendars;

  SectionMyListCalendar({this.calendars});

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
          child: ListView.separated (
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return ItemCalendar(colorIcon: Colors.white, title: "Lunch", count: 1);
              },
          ),
        )
      ],
    );
  }
}

class ItemCalendar extends StatelessWidget {
  final Color colorIcon;
  final String title;
  final int count;

  ItemCalendar({this.colorIcon, this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Icon(
                  Icons.list,
                  color: colorIcon,
                  size: 25,
                ),
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18
                ),
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
    );
  }
}
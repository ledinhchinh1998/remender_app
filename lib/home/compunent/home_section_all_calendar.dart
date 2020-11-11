import 'package:flutter/material.dart';
import 'package:remender_new/compunent_widget/text_widget.dart';
import '../home_screen.dart';

class SectionAllCalendar extends StatelessWidget {
  final String title;
  final int count;

  SectionAllCalendar({this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Icon(
                    Icons.all_inbox_sharp,
                    size: 25,
                  )
              ),
              SizedBox(height: 10),
              Text(
                  title,
                  style: styleTitleHome
              ),
            ],
          ),
          TextComponent(title: count.toString(), style: styleCountScheduler)
        ],
      ),
    );
  }
}
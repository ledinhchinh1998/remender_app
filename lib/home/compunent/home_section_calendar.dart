import 'package:flutter/material.dart';
import 'package:remender_new/compunent_widget/text_widget.dart';
import '../home_screen.dart';

class SectionCalender extends StatelessWidget {
  final String imgPath;
  final String title;
  final int count;
  final Function onclick;
  final Color color;

  SectionCalender({this.imgPath, this.title, this.count, this.onclick, this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: decorationContainer,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.asset(
                        imgPath,
                        width: 25,
                        height: 25,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: color
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    SizedBox(height: 10),
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                TextComponent(title: count.toString(), style: styleCountScheduler),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
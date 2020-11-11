import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepeatScreen extends StatefulWidget {
  @override
  _RepeatScreenState createState() => _RepeatScreenState();
}

class _RepeatScreenState extends State<RepeatScreen> {

  List<String> listRepeat = [
    "Not",
    "Daily",
    "Every week",
    "Twice a week",
    "Monthly",
    "Every 3 months",
    "Every 6 months",
    "Annualy"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: Colors.grey[800],
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.back();
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        listRepeat[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Visibility(
                        visible: true,
                        child: Icon(
                          Icons.done,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(
                  height: 1,
                  color: Colors.black26,
                ),
                SizedBox(height: 5),
              ],
            ),
          );
        },
        itemCount: listRepeat.length,
      ),
    );
  }
}

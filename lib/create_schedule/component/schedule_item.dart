import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class ScheduleItem extends StatelessWidget {
  bool isChecked;
  String title;
  String momentSchedule;
  FocusNode focusNode;
  Function(String value) onchange;
  Function(String value) onSubmitted;
  Function onPressedInfo;

  ScheduleItem({this.isChecked, this.title, this.momentSchedule, this.focusNode, this.onchange, this.onSubmitted, this.onPressedInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          CircularCheckBox(
            value: true,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: (bool) {

            },
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 145,
                child: TextField(
                  focusNode: focusNode,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),
                  onChanged: (value) {
                    onchange(value);
                  },
                  onSubmitted: (value) {
                    onSubmitted(value);
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                momentSchedule,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
              SizedBox(height: 5),
              Container(
                color: Colors.grey,
                height: 0.5,
                width: MediaQuery.of(context).size.width - 145,
                child: Center(),
              )
            ],
          ),
          FlatButton(
            minWidth: 50,
            onPressed: () {
              onPressedInfo();
            },
            child: Icon(
              Icons.info,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class ScheduleItem extends StatelessWidget {
  final int isChecked;
  final String title;
  final String momentSchedule;
  final FocusNode focusNode;
  final Function(String value) onchange;
  final Function(String value) onSubmitted;
  final Function(bool onChange) onChangeStick;
  final Function onPressedInfo;


  ScheduleItem({this.isChecked, this.title, this.momentSchedule, this.focusNode, this.onchange, this.onSubmitted, this.onPressedInfo, this.onChangeStick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          CircularCheckBox(
            disabledColor: Colors.red,
            inactiveColor: Colors.white,
            value: isChecked == 0 ? false : true,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: (value) {
              print(value);
              onChangeStick(value);
            },
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 145,
                child: TextField(
                  controller: TextEditingController(
                    text: title
                  ),
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

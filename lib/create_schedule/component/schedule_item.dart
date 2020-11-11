import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class ScheduleItem extends StatelessWidget {
  final int isChecked;
  final String title;
  final String note;
  final String momentSchedule;
  final FocusNode focusNode;
  final Function(String value) onchange;
  final Function(String value) onSubmitted;
  final Function() onChangeStick;
  final Function onPressedInfo;

  ScheduleItem(
      {this.isChecked,
      this.title,
      this.momentSchedule,
      this.focusNode,
      this.onchange,
      this.onSubmitted,
      this.onPressedInfo,
      this.onChangeStick,
      this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isChecked == 0 ? Colors.white30 : Colors.blue,
      elevation: 5,
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            CircularCheckBox(
              inactiveColor: Colors.white,
              checkColor: Colors.blue,
              activeColor: Colors.white,
              value: isChecked == 0 ? false : true,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onChanged: (value) {
                onChangeStick();
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 145,
                  child: TextField(
                    controller: TextEditingController(text: title),
                    focusNode: focusNode,
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    onChanged: (value) {
                      onchange(value);
                    },
                    onSubmitted: (value) {
                      onSubmitted(value);
                    },
                  ),
                ),
                Text(
                  momentSchedule,
                  style: TextStyle(
                      color: isChecked == 0 ? Colors.grey : Colors.white,
                      fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Expanded(
              child: FlatButton(
                minWidth: 50,
                onPressed: () {
                  onPressedInfo();
                },
                child: Icon(
                  Icons.info,
                  color: isChecked == 0 ? Colors.blue : Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

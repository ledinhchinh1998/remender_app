import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:remender_new/create_schedule/component/repeat_schedule.dart';
import '../create_schedule_controller.dart';
import 'list_schedule.dart';

class DetailScheduleScreen extends StatefulWidget {

  final int index;


  DetailScheduleScreen({this.index});

  @override
  _DetailScheduleScreenState createState() => _DetailScheduleScreenState();
}

class _DetailScheduleScreenState extends State<DetailScheduleScreen> {
  DateTime dateTime = DateTime.now();
  CreateScheduleController controller = Get.find();
  var titleController = TextEditingController();
  var noteController = TextEditingController();

  void _showDemoPicker({
    @required BuildContext context,
    @required Widget child,
  }) {
    final themeData = CupertinoTheme.of(context);
    final dialogBody = CupertinoTheme(
      data: themeData,
      child: child,
    );

    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => dialogBody,
    );
  }


  @override
  void initState() {
    titleController.text = controller.listSchedule.value[widget.index].title;
    noteController.text = controller.listSchedule.value[widget.index].note ?? "";
    super.initState();
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDemoPicker(
          context: context,
          child: _BottomPicker(
            child: CupertinoDatePicker(
              backgroundColor:
              CupertinoColors.systemBackground.resolveFrom(context),
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: dateTime,
              onDateTimeChanged: (newDateTime) {
                controller.listSchedule[widget.index].dateTime = newDateTime.toString();
                print(controller.listSchedule[widget.index].dateTime);
                setState(() => dateTime = newDateTime);
              },
            ),
          ),
        );
      },
      child: _Menu(
        children: [
          Text(""),
          Flexible(
            child: Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              style: const TextStyle(color: CupertinoColors.inactiveGray),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.grey[800],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                        onPressed: (){
                          controller.deleteNote(controller.listSchedule.value[widget.index]);
                          Get.back();
                        },
                        child: Text("Delete", style: TextStyle(
                            color: Colors.red,
                            fontSize: 18
                        ))
                    )
                ),
                Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                      onPressed: null,
                      child: Text("Detail", style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ))
                  )
                ),
                Align(
                  alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        var note = controller.listSchedule.value[widget.index];
                        note.title = titleController.text;
                        note.note = noteController.text;
                        note.dateTime = dateTime.toString();
                        controller.updateNotes(note);
                        Get.back();
                      },
                      child: Text("Done", style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18
                    ))
                    )
                )
              ],
            ),
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.black54,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: titleController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                    hintStyle: TextStyle(
                      color: CupertinoColors.inactiveGray
                    )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: noteController,
                onChanged: (value) {
                  controller.listSchedule[widget.index].note = value;
                },
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(
                      color: CupertinoColors.inactiveGray
                  )
                ),
              ),
            ),
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.black54,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      "Reminds me on",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Flexible(flex: 1 ,child: _buildDateAndTimePicker(context))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                height: 1,
                color: Colors.black26,
              ),
            ),
            InkWell(
              onTap: () {
                Get.bottomSheet(RepeatScreen());
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repeat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Not",
                          style: TextStyle(
                              color: CupertinoColors.inactiveGray,
                              fontSize: 18
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: CupertinoColors.inactiveGray
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                height: 1,
                color: Colors.black26,
              ),
            ),
            InkWell(
              onTap: () {
                Get.bottomSheet(ChangeList());
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                            Icons.arrow_forward_ios,
                            color: CupertinoColors.inactiveGray
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BottomPicker extends StatelessWidget {
  const _BottomPicker({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    Key key,
    @required this.children,
  })  : assert(children != null),
        super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}

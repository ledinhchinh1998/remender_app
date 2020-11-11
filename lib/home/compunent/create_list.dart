import 'package:flutter/material.dart';
import 'package:remender_new/home/model/list_model.dart';

class CreateListScreen extends StatefulWidget {
  @override
  _CreateListScreenState createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  Color colorBg = Colors.lightBlue;
  List<Color> listColor = [
    Colors.deepOrange,
    Colors.amber,
    Colors.amberAccent,
    Colors.green,
    Colors.lightBlue,
    Colors.deepPurpleAccent,
    Colors.brown
  ];

  String title = "";

  Color borderColor = Colors.black26;

  void doneAction() {
    ListModel listModel = ListModel(title: title, color: colorBg.toString(), count: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: Text(
          "New list",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorBg,
                  borderRadius: BorderRadius.circular(60)
                ),
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.list,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                  )
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: listColor.map((item) => GestureDetector(
                  onTap: () {
                    print(item.toString());
                    colorBg = item;
                    setState(() {

                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: item,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(25)
                    ),
                  ),
                )).toList().cast<Widget>(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

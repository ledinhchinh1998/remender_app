import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  final TextEditingController controller;
  final Function(String value) onTextChange;
  final FocusNode nodeFocus;

  SearchBar({this.controller, this.onTextChange, this.nodeFocus});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: TextFormField(
            controller: controller,
            onChanged: (value) =>  onTextChange(value),
            focusNode: nodeFocus,
            decoration: InputDecoration(
                focusColor: null,
                contentPadding: EdgeInsets.all(8),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: Colors.grey
                  ),
                ),
                fillColor: Colors.grey[800],
                filled: true,
                hintStyle: TextStyle(
                    color: Colors.grey
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(12)
                )
            ),
          ),
        ),
        Flexible(
          flex: nodeFocus.hasFocus ? 3 : 0,
          child: Visibility(
            visible: nodeFocus.hasFocus ? true : false,
            child: FlatButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
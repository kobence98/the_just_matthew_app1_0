import 'package:TheJustMatthewApp/widgets/menu_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'entities/file.dart';

List<FileData> ?files;
List<String> ?parts = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: new MenuListWidget());
  }
}

import 'package:TheJustMatthewApp/entities/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'all_from_tapped_part_widget.dart';

String ?actualPart;

class MenuListWidget extends StatefulWidget {
  @override
  _MenuListWidgetState createState() => _MenuListWidgetState();
}

class _MenuListWidgetState extends State<MenuListWidget> {
  @override
  void initState() {
    super.initState();
    if (files == null) {
      readFileByLines().then((result) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _menuScaffold();
  }

  Widget _menuScaffold() {
    return Scaffold(
        appBar: AppBar(
          title: new Center(
              child: Text('R.I.P TheJustMatthew', textAlign: TextAlign.center)),
        ),
        backgroundColor: Colors.black,
        body: _menuListView());
  }

  Widget _menuListView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.0),
      itemCount: parts!.length,
      itemBuilder: (context, position) {
        return Card(
          color: Colors.indigo[800],
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  parts!.elementAt(position),
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                _onPartTapped(position);
              });
            },
          ),
        );
      },
    );
  }

  void _onPartTapped(int position) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          actualPart = parts!.elementAt(position);
          return new AllFromTappedPartWidget();
        },
      ),
    );
  }
}

Future<String> loadTXT() async {
  return await rootBundle.loadString("assets/text_files/file_names.txt");
}

Future<bool> readFileByLines() async {
  Fluttertoast.showToast(
      msg: "read started",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
  files = [];
  String data = await loadTXT();
  List<String> lines = data.split("\n");

  Fluttertoast.showToast(
      msg: lines.elementAt(0),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
  for (int i = 0; i < int.parse(lines.elementAt(0)); i++) {
    FileData fileData = new FileData(
        i,
        lines.elementAt((i + 1) * 4 - 3),
        lines.elementAt((i + 1) * 4 - 2),
        lines.elementAt((i + 1) * 4 - 1),
        lines.elementAt((i + 1) * 4) == "true" ? true : false);
    files!.add(fileData);
  }

  for (int i = 0; i < files!.length; i++) {
    if (!parts!.contains(files!.elementAt(i).part)) {
      parts!.add(files!.elementAt(i).part);
    }
  }
  Fluttertoast.showToast(
      msg: "read ended",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
  return true;
}

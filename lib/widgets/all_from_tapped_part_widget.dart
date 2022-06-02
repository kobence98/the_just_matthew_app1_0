import 'package:TheJustMatthewApp/entities/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../main.dart';
import 'menu_list_widget.dart';
import 'play_button.dart';

class AllFromTappedPartWidget extends StatefulWidget {
  @override
  _AllFromTappedPartWidgetState createState() =>
      _AllFromTappedPartWidgetState();
}

String ?fileName;

class _AllFromTappedPartWidgetState extends State<AllFromTappedPartWidget> {
  List<FileData> partFiles = [];
  bool isPlaying = false;
  bool allLiked = false;
  bool _result = false;
  bool allLikedTappedOrInit = true;

  @override
  Widget build(BuildContext context) {
    if(allLikedTappedOrInit){
      readPartFiles().then((result) {
        setState(() {
          _result = result;
        });
      });
    }
    if (!_result) {
      return new Container();
    } else {
      return Scaffold(
          appBar: AppBar(
            title: new Center(
              child: Text(actualPart!, textAlign: TextAlign.center),
            ),
          ),
          backgroundColor: Colors.black,
          body: _mediaFilesListView());
    }
  }

  Future<bool> readPartFiles() async {
    if (allLiked && allLikedTappedOrInit) {
      partFiles.clear();
      for (int i = 0; i < files!.length; i++) {
        if (files!.elementAt(i).part == actualPart &&
            files!.elementAt(i).isLiked) {
          partFiles.add(files!.elementAt(i));
        }
      }
    } else if (allLikedTappedOrInit) {
      partFiles.clear();
      for (int i = 0; i < files!.length; i++) {
        if (files!.elementAt(i).part == actualPart) {
          partFiles.add(files!.elementAt(i));
        }
      }
    }
    allLikedTappedOrInit = false;
    return true;
  }

  //ALL LIKED BUTTON WIDGET

  Widget allLikeButton() {
    return new LikeButton(
      isLiked: allLiked,
      size: 30.0,
      circleColor:
          CircleColor(start: Color(0xFFF44336), end: Color(0xFFF44336)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xFFF44336),
        dotSecondaryColor: Color(0xFFF44336),
      ),
      likeBuilder: (bool allLiked) {
        return Icon(
          Icons.favorite,
          color: allLiked ? Colors.red : Colors.white,
          size: 30.0,
        );
      },
    );
  }

  //PART FILES LIST VIEW WIDGET

  Widget _mediaFilesListView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.0),
      itemCount: partFiles.length,
      itemBuilder: (context, position) {
        return new Card(
          color: Colors.indigo[800],
          child: Row(children: <Widget>[
            new Container(
              child: new InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    partFiles.elementAt(position).title,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  ),
                ),
              ),
              width: (MediaQuery.of(context).size.width - 32) / 7 * 6,
            ),
            new Container(
              child: SizedBox(
                height: 30,
                width: 30,
                child: PlayButton(
                  initialIsPlaying: isPlaying,
                  pauseIcon: Icon(Icons.pause, color: Colors.white, size: 17),
                  playIcon:
                      Icon(Icons.play_arrow, color: Colors.white, size: 17),
                  onPressed: () {
                    _playButtonPressed(partFiles.elementAt(position).fileName);
                  },
                ),
              ),
              width: (MediaQuery.of(context).size.width - 32) / 7,
            ),
          ]),
        );
      },
    );
  }

//LIKE BUTTON WIDGET

  Widget likeButton(int position) {
    return new LikeButton(
      isLiked: partFiles.elementAt(position).isLiked,
      size: 30.0,
      circleColor:
          CircleColor(start: Color(0xFFF44336), end: Color(0xFFF44336)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xFFF44336),
        dotSecondaryColor: Color(0xFFF44336),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.red : Colors.white,
          size: 30.0,
        );
      },
    );
  }

  //PLAY BUTTON PRESSED

  void _playButtonPressed(String fn) async {
    setState(() {
      fileName = fn;
    });
  }
}

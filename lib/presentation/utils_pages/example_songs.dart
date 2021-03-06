import 'package:flutter/material.dart';
import 'package:music_scales/presentation/core/const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Song {
  final String artist;
  final String song;
  final String section;
  final String url;

  Song(
      {required this.artist,
      required this.song,
      required this.section,
      required this.url});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      artist: json['artist'],
      song: json['song'],
      section: json['section'],
      url: json['url'],
    );
  }
}

class SongsListScreen extends StatefulWidget {
  @override
  _SongsListScreen createState() => _SongsListScreen();
}

class _SongsListScreen extends State<SongsListScreen> {
  int chordnum = 2;
  int paramlength = 2;
  String globalappbarprog = "1-2";

  var buttonitems = [
    ["1", "2", "3", "4", "5", "6", "7"],
    ["1", "2", "3", "4", "5", "6", "7"],
    ["1", "2", "3", "4", "5", "6", "7"],
    ["1", "2", "3", "4", "5", "6", "7"]
  ];
  List<String> param = ["1", "2", "3", "4"];
  List<String> buttonhint = ["1", "2", "3", "4"];

  ListView mylist(List<Song> mysongs) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 0,
          color: Colors.black26,
        );
      },
      itemCount: mysongs.length,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            String url = mysongs[index].url;
            _launchURL(url);
          },
          contentPadding: EdgeInsets.fromLTRB(14, 9, 0, 8),
          title: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                    child: Container(
                        child: Text(
                  "${mysongs[index].song}",
                  style: TextStyle(fontSize: 22),
                  overflow: TextOverflow.ellipsis,
                )))
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 7),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: Container(
                            child: Text(
                      "${mysongs[index].artist} - ${mysongs[index].section}",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    )))
                  ],
                )),
          ]),
        );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Row chordlists(int number) {
    if (number == 2) {
      return Row(children: <Widget>[
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[0]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[0].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[0] = newValueSelected;
              param[0] = newValueSelected;
            });
          },
        ),
        Text(" "),
        Container(
          width: 1,
          height: 30,
          color: Colors.grey,
        ),
        Text(" "),
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[1]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[1].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[1] = newValueSelected;
              param[1] = newValueSelected;
            });
          },
        ),
      ]);
    } else if (number == 3) {
      return Row(children: <Widget>[
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[0]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[0].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[0] = newValueSelected;
              param[0] = newValueSelected;
            });
          },
        ),
        Text(" "),
        Container(
          width: 1,
          height: 30,
          color: Colors.grey,
        ),
        Text(" "),
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[1]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[1].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[1] = newValueSelected;
              param[1] = newValueSelected;
            });
          },
        ),
        Text(" "),
        Container(
          width: 1,
          height: 30,
          color: Colors.grey,
        ),
        Text(" "),
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[2]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[2].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[2] = newValueSelected;
              param[2] = newValueSelected;
            });
          },
        ),
      ]);
    } else {
      return Row(children: <Widget>[
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[0]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[0].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[0] = newValueSelected;
              param[0] = newValueSelected;
            });
          },
        ),
        Text(" "),
        Container(
          width: 1,
          height: 30,
          color: Colors.grey,
        ),
        Text(" "),
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[1]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[1].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[1] = newValueSelected;
              param[1] = newValueSelected;
            });
          },
        ),
        Text(" "),
        Container(
          width: 1,
          height: 30,
          color: Colors.grey,
        ),
        Text(" "),
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[2]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[2].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[2] = newValueSelected;
              param[2] = newValueSelected;
            });
          },
        ),
        Text(" "),
        Container(
          width: 1,
          height: 30,
          color: Colors.grey,
        ),
        Text(" "),
        DropdownButton<String>(
          hint: Text(
            "${buttonhint[3]}",
            style: TextStyle(fontSize: 24),
          ),
          items: buttonitems[3].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                "$value",
                style: TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            if (newValueSelected == null) return;
            setState(() {
              buttonitems = [
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"],
                ["1", "2", "3", "4", "5", "6", "7"]
              ];
              buttonhint[3] = newValueSelected;
              param[3] = newValueSelected;
            });
          },
        ),
      ]);
    }
  }

  Future<List<Song>> fetchSong(String mode, List<dynamic> chords) async {
    String url = "";
    for (int i = 0; i < paramlength; i++) {
      if (i == paramlength - 1)
        url += chords[i];
      else
        url += chords[i] + ",";
    }
    final response = await http.get(
      'https://api.hooktheory.com/v1/trends/${mode}?cp=${url}',
      headers: {"Authorization": "Bearer $bearerToken"},
    );
    final responseJson = json.decode(response.body);

    final response2 = await http.get(
      'https://api.hooktheory.com/v1/trends/${mode}?cp=${url}&page=2',
      headers: {"Authorization": "Bearer $bearerToken"},
    );
    final responseJson2 = json.decode(response2.body);

    final response3 = await http.get(
      'https://api.hooktheory.com/v1/trends/${mode}?cp=${url}&page=3',
      headers: {"Authorization": "Bearer $bearerToken"},
    );
    final responseJson3 = json.decode(response3.body);
    List<Song> mysong = [];
    for (int i = 0; i < 5; i++) mysong.add(Song.fromJson(responseJson[i]));
    for (int i = 0; i < 5; i++) mysong.add(Song.fromJson(responseJson2[i]));
    for (int i = 0; i < 5; i++) mysong.add(Song.fromJson(responseJson3[i]));

    return mysong;
  }

  @override
  Widget build(BuildContext context) {
    globalappbarprog = "";
    for (int i = 0; i < paramlength; i++) {
      if (i == paramlength - 1)
        globalappbarprog += param[i];
      else
        globalappbarprog += param[i] + "-";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Progression: $globalappbarprog",
            style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.help,
                  size: 30,
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctxt) => AlertDialog(
                        title: Text(
                          "Help",
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                            "Select the number of chords, and the chords. View popular songs that contain this progression in them. Click on the song to view it in www.hooktheory.com.\n\nData provided by www.hooktheory.com"),
                      ));
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Color.fromRGBO(250, 250, 250, 1),
        padding: EdgeInsets.only(right: 6, bottom: 2, top: 2),
        child: Text(
          "Provided by hooktheory.com",
          style: TextStyle(color: Colors.grey, fontSize: 9),
          textAlign: TextAlign.right,
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 8),
          color: Color.fromRGBO(255, 225, 225, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Number Of Chords:  ", style: TextStyle(fontSize: 24)),
              DropdownButton<int>(
                hint: Text(
                  "$chordnum",
                  style: TextStyle(fontSize: 24),
                ),
                items: <int>[2, 3, 4].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      "$value",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
                onChanged: (newValueSelected) {
                  if (newValueSelected == null) return;
                  setState(() {
                    param[0] = "1";
                    param[1] = "2";
                    param[2] = "3";
                    param[3] = "4";
                    buttonhint = ["1", "2", "3", "4"];
                    paramlength = newValueSelected;
                    chordnum = newValueSelected;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          color: Color.fromRGBO(225, 250, 250, 1),
          padding: EdgeInsets.only(top: 10, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Chords:  ", style: TextStyle(fontSize: 24)),
              chordlists(chordnum),
            ],
          ),
        ),
        Divider(
          height: 0,
          color: Colors.black26,
        ),
        FutureBuilder<List<Song>>(
          future: fetchSong("songs", param),
          builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Padding(
                    padding: EdgeInsets.fromLTRB(6, 26, 6, 6),
                    child: Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor: Colors.orangeAccent,
                    )));
              default:
                if (snapshot.hasError)
                  return Center(
                      child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 4),
                        child: Text('No data available',
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    Icon(Icons.error, color: Colors.red),
                  ]));
                else if (snapshot.data != null)
                  return Flexible(child: mylist(snapshot.data!));
                else
                  return Container();
            }
          },
        )
      ]),
    );
  }
}

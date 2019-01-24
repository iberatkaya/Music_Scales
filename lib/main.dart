import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chords.dart';
import 'scales.dart';
import 'prog.dart';

void main() { 
  /*SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {*/runApp(MyApp());/*});*/
}

class Note{
  String note;
  int index;
  Note(this.note, this.index);
}

class Chord{
  String note;
  int index;
  List<int> formula;
  Chord(this.note, this.index, this.formula);
}


class Scale{
  String name;
  int index;
  List<int> formula;
  Scale(this.name, this.index, this.formula);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        iconTheme: IconThemeData(
          size: 25,
          opacity: 1,
        ),
      ),
      home: MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String instrument;
double textSize = 28.0;
String speed;
int typeselect;   //0 for scale, 1 for chord, 2 for progression

var clickednote = "";
var clickedindex = 0;
var clickednotescale = "";
var clickedindexscale = 0;
List<Note> notes = [
  Note("A", 0),
  Note("A#", 1),
  Note("B", 2),
  Note("C", 3),
  Note("C#", 4),
  Note("D", 5),
  Note("D#", 6),
  Note("E", 7),
  Note("F", 8),
  Note("F#", 9),
  Note("G", 10),
  Note("G#", 11),
];


class _MyHomePageState extends State<MyHomePage> {

@override
  void initState() {
    super.initState();
    //_loadSize();
    _loadInstr();
    _loadSpeed();
  }

  _loadInstr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      instrument = (prefs.getString('instrument') ?? "Piano");
    });
  }

  /*_loadSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      textSize = (prefs.getDouble('textSize') ?? 28.0);
    });
  }*/

  _loadSpeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      speed = (prefs.getString('speed') ?? "Fast");
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('lib/assets/imgs/logo.jpg'), context);
    return new ListTileTheme(
      iconColor: Colors.red,
      child:
       Scaffold(
        appBar: AppBar(
          title: Text("Music Scales", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView( 
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
              //height: 110,
              color: Colors.orangeAccent,
              child: DrawerHeader(
                
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage('lib/assets/imgs/logo.jpg')),
               ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(2, 1, 2, 0), child: Divider(height: 0, color: Colors.black54,)),
              ListTile(
                title: Text('Settings', style: TextStyle(fontSize: 18)),
                trailing: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: RaisedButton(
                      onPressed: (){
                          typeselect = 0;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                        },
                        elevation: 1,
                        highlightElevation: 1,
                        padding: EdgeInsets.fromLTRB(30, 27, 30, 27),
                        color: Color.fromRGBO(240, 120, 120, 0.7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        child: Center( child: Text("Scales 🎹", style: TextStyle(fontSize: textSize + 3, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: RaisedButton(
                      onPressed: (){
                        typeselect = 1;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                      },
                      elevation: 1,
                      highlightElevation: 1,
                      padding: EdgeInsets.fromLTRB(30, 27, 30, 27),
                      color: Color.fromRGBO(120, 240, 120, 0.7),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child:  Center( child: Text("Chords 🎸", style: TextStyle(fontSize: textSize + 3, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Divider(height: 0, color: Colors.black54,)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: RaisedButton(
                      onPressed: (){
                          typeselect = 2;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen()));
                        },
                      elevation: 1,
                      highlightElevation: 1,
                      padding: EdgeInsets.fromLTRB(30, 27, 30, 27),
                      color: Color.fromRGBO(150, 165, 250, 0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child:  Center( child: Text("Progressions 🎼", style: TextStyle(fontSize: textSize + 3, fontWeight: FontWeight.normal),),),
                    ),
                  ),
                  //Padding(padding: EdgeInsets.fromLTRB(4, 0, 2, 0), child: Divider(height: 4, color: Colors.black54,)),
                ],
              ),
              ),
            ],
          ),
        ),
      )
      );
    }
  }

class NoteScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {

    return
       Scaffold(
        appBar: AppBar(
          title: Text("Notes", style: TextStyle(color: Color.fromRGBO(20, 20, 20, 1))),
          elevation: 1,
        ),
        body: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1,
          padding: EdgeInsets.fromLTRB(12, 24, 12, 0),
          children: List.generate(12, (index){
            return Center(
              child: Container( 
                  width: 42 + textSize * 1.65,
                  height: 42 + textSize * 1.65,
                  //decoration: BoxDecoration(, borderRadius: BorderRadius.circular(36)),
                  child:RaisedButton(
                onPressed: (){
                  clickedindex = notes[index].index;
                  clickednote = notes[index].note;
                  key = notes[index].note;
                  if(typeselect == 0) 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScaleScreen()));
                  else if(typeselect == 1) 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChordScreen()));
                  else if(typeselect == 2) 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProgScreen()));
                },
                elevation: 1,
                highlightElevation: 1,
                color: Color.fromRGBO(202, 242, 242, 0.9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
                
                child:  Center(
                    child: Text("${notes[index].note}", style: TextStyle(color: Color.fromRGBO(255, 19, 23, 1), fontSize: textSize * 1.2, fontWeight: FontWeight.normal),)),
                  ),
              ),
              );
            }
          ),
        ),
      );
    }
}

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
/*
  _changeText(double temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble('textSize', temp);
    });
  }
  _loadSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      textSize = (prefs.getDouble('textSize') ?? 28.0);
    });
  }
*/
  _changeInstr(String temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('instrument', temp);
    });
  }
  _loadInstr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      instrument = (prefs.getString('instrument') ?? "Piano");
    });
  }
  
  _changeSpeed(String temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('speed', temp);
    });
  }

  _loadSpeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      speed = (prefs.getString('speed') ?? "Fast");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
          elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
              padding: EdgeInsets.all(6),
              child: Row(              
                children: <Widget>[
                  Text("Instrument:    ", style: TextStyle(fontSize: 18),),
                  DropdownButton<String>(
                  hint: Text("$instrument", style: TextStyle(fontSize: 18),),
                  items: <String>["Piano", "Guitar"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text("$value"),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    _changeInstr(newValueSelected);
                    _loadInstr();
                   },
                  ),
                ],
              ),
             ),
            Divider(height: 0, color: Color.fromRGBO(0, 0, 200, 0.2),),
             Container(
              margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
              padding: EdgeInsets.all(6),
              child: Row(              
                children: <Widget>[
                  Text("Audio Speed:    ", style: TextStyle(fontSize: 18),),
                  DropdownButton<String>(
                  hint: Text("$speed", style: TextStyle(fontSize: 18),),
                  items: <String>["Fast", "Slow"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text("$value"),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    _changeSpeed(newValueSelected);
                    _loadSpeed();
                   },
                  ),
                ],
              ),
             ),
            Divider(height: 0, color: Color.fromRGBO(0, 0, 200, 0.2),),
            /*Container(
              margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
              padding: EdgeInsets.all(5),
              child: Row(              
                children: <Widget>[
                  Text("Select Text Size:  ", style: TextStyle(fontSize: 18),),
                  DropdownButton<double>(
                  hint: Text("${textSize.toInt()}", style: TextStyle(fontSize: 18),),
                  items: <double>[24, 26, 28, 30].map((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text("${value.toInt()}"),
                    );
                  }).toList(),
                  onChanged: (double newValueSelected) {
                    _changeText(newValueSelected);
                    _loadSize();
                   },
                  ),
                ],
              ),
             ),
                Divider(height: 1, color: Color.fromRGBO(0, 0, 200, 0.2),),*/
          ],
        ),
      ),
    );
  }
}

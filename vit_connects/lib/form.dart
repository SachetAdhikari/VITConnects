import 'package:flutter/material.dart';
import './main.dart';

class Forms extends StatefulWidget {
  Forms({Key? key}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  final coursename = ['SE', 'ISAA', 'DSA'];
  String? course;
  final coursecode = ['CSE3001', 'CSE4001', 'CSE5001'];
  String? coursec;
  final facultyname = ['Sachet', 'Subham', 'OK'];
  String? faculty;
  final slot = ['E1', 'G1', 'A1'];
  String? s;
  @override
  Widget _button(String textt, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        elevation: 0,
        height: 60,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Forms()),
          );
        },
        color: bc,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 28, color: Colors.white, fontFamily: 'ProximaNova'),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("VIT CONNECT's",
            style: TextStyle(fontFamily: 'ProximaNova')),
        backgroundColor: pc,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Course Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                      //color: Colors.white,
                      ),
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: course,
                      isExpanded: true,
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: coursename.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => course = value),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Course Code",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'

                      //color: Colors.white,
                      ),
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: coursec,
                      isExpanded: true,
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: coursecode.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => coursec = value),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Slot",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                      //color: Colors.white,
                      ),
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: s,
                      isExpanded: true,
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: slot.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => s = value),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Faculty Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                      //color: Colors.white,
                      ),
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: course,
                      isExpanded: true,
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: facultyname.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => faculty = value),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                _button("Join", context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}

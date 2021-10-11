import 'package:flutter/material.dart';
import './main.dart';

class Forms extends StatefulWidget {
  Forms({Key? key}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget _button(String textt, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        elevation: 0,
        height: 80,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Forms()),
          );
        },
        color: buttonc,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textt,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28, color: Colors.white, fontFamily: 'Red Rose'),
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
        title: Text("VIT CONNECT's"),
        backgroundColor: pc,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                "Course Name",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.white,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Course Name',
                  //labelText: 'Course Name',
                ),
              ),
              Text(
                "Course Code",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.white,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Course Code',
                  //labelText: 'Course Code',
                ),
              ),
              Text(
                "Slot",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.white,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Slot',
                  //labelText: 'Course',
                ),
              ),
              Text(
                "Faculty Name",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.white,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  //labelText: 'Course',
                ),
              ),
              _button("Join", context),
            ],
          ),
        ),
      ),
    );
  }
}

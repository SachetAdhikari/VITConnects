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
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Course Name',
                      hintStyle:
                          TextStyle(fontFamily: 'ProximaNova', fontSize: 17)
                      //labelText: 'Course Name',
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Course Code',
                    hintStyle: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                        //color: Colors.white,
                        ),
                    //labelText: 'Course Code',
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Slot',
                    hintStyle: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                        //color: Colors.white,
                        ),
                    //labelText: 'Course',
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                        //color: Colors.white,
                        ),
                    //labelText: 'Course',
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
}

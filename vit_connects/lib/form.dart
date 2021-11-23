import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './main.dart';

class Forms extends StatefulWidget {
  Forms({Key? key}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  String coursename = '';
  final courseController = TextEditingController();
  final slotController = TextEditingController();
  final facultyController = TextEditingController();
  String faculty = '';
  String slot = '';
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      } else {
        print('no user found');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _button(String textt, BuildContext context, String slot,
      String coursename, String faculty) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        elevation: 0,
        height: 60,
        onPressed: () {
          if (coursename != null) {
            _firestore.collection('user').add({
              'course': coursename,
              'email': loggedInUser.email, //from firebase
              'faculty': faculty,
              'slot': slot,
            });
          }
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
                TextField(
                  // controller: messageController,
                  //     onChanged: (value) {
                  //       coursename = value;
                  //     },
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
                TextField(
                  controller: courseController,
                  onChanged: (value) {
                    coursename = value;
                  },
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
                TextField(
                  controller: slotController,
                  onChanged: (value) {
                    slot = value;
                  },
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
                TextField(
                  controller: facultyController,
                  onChanged: (value) {
                    faculty = value;
                  },
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
                _button("Join", context, coursename, slot, faculty),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    return GestureDetector(
      onTap: () {
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
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 60),
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("VIT CONNECT's",
            style: TextStyle(
                fontFamily: 'ProximaNova', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.03,
                    ),
                    const Text(
                      "Course Name",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                          //color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //validator: (val) => val.isEmpty ? 'Enter an Email' : null,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),

                        //labelText: 'Username',
                        hintText: 'Course Name',
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //validator: (val) => val.isEmpty ? 'Enter an Email' : null,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Course Code',
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //validator: (val) => val.isEmpty ? 'Enter an Email' : null,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Slot',
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //validator: (val) => val.isEmpty ? 'Enter an Email' : null,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Name',
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
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
        ),
      ),
    );
  }
}

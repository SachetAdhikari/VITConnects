import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vit_connects/form.dart';
import './main.dart';

class Formss extends StatefulWidget {
  Formss({Key? key}) : super(key: key);

  @override
  _FormssState createState() => _FormssState();
}

class _FormssState extends State<Formss> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  String title = '';
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String description = '';
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

  Widget _button(String textt, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (coursename != null) {
        //   _firestore.collection('user').add({
        //     'course': coursename,
        //     'email': loggedInUser.email, //from firebase
        //     'faculty': faculty,
        //     'slot': slot,
        //   });
        // }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Formss()),
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
        title: const Text("To Do Details",
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
                      height: size.height * 0.10,
                    ),
                    const Text(
                      "Title",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                          //color: Colors.white,
                          ),
                    ),
                    TextField(
                      controller: titleController,
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle:
                              TextStyle(fontFamily: 'ProximaNova', fontSize: 17)
                          //labelText: 'Course Name',
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Brief",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'

                          //color: Colors.white,
                          ),
                    ),
                    TextField(
                      controller: descriptionController,
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        hintStyle:
                            TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                                //color: Colors.white,
                                ),
                        //labelText: 'Course Code',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.date_range),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            print('Yay!');
                          },
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Date Created',
                            ),
                            readOnly:
                                true, // Or wrap the input with AbsorbPointer if you do not want the field to get highlighted by taping on it
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (title != null) {
                          _firestore.collection('ToDo').add({
                            'title': title,
                            'email': loggedInUser.email, //from firebase
                            'description': description,
                          });
                        }
                        titleController.clear();
                        descriptionController.clear();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Formss()),
                        // );
                      },
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.red),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Add Task",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontFamily: 'ProximaNova'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //_button("Join", context),
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

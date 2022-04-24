import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vit_connects/form.dart';
import './main.dart';
import 'dart:async';
import 'groups.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// For changing the language
//import 'package:flutter_localizations/flutter_localizations.dart';

class Formz extends StatefulWidget {
  // String? title; //optional paremeters
  // String? brief;
  // DateTime? dt;
  // Formz({Key? key, this.title, this.brief, this.dt}) : super(key: key);

  @override
  _FormzState createState() => _FormzState();
}

class _FormzState extends State<Formz> {
  // DateTime? _dateTime;
  // //DateTime? now;
  // String formattedDate =
  // DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  // final _formKey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  // late User loggedInUser;
  // final _firestore = FirebaseFirestore.instance;
  // String title = '';
  // final titleController = TextEditingController();
  // final descriptionController = TextEditingController();
  // String description = '';


////  ###################################



  final _formKey = GlobalKey<FormState>();
  List<String> courses = ['Choose Course'];
  List<String> faculties = ['Choose Faculty'];
  List<String> slots = ['Choose Slot'];

  // form values
  String _course ='Choose Course';
  String _faculty ='Choose Faculty';
  String _slot ='Choose Slot';

  bool cCheck=false;
  bool fCheck=false;
  bool sCheck=false;

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getCourse();
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
  void getCourse() async{
    final courseList = await _firestore.collection('course').get();
    for(var courseData in courseList.docs){
      for (var cID in courseData.data()['id'].keys){
        courses.add(cID);
        print(cID);
      }
    }
  }

  void getCourseFaculty(String course) async{
    faculties=['Choose Faculty'];
    final courseList = await _firestore.collection('course').get();
    for(var courseData in courseList.docs){
      var a = courseData.data().values.toList();
      a[0].forEach((k,v){
        if(k==course){
          v.forEach((name,slot){
            faculties.add(name);
          });
        }
      } );
    }
  }

  void getCourseFacultySlot(String course, String faculty) async{
    slots=['Choose Slot'];
    final courseList = await _firestore.collection('course').get();
    for(var courseData in courseList.docs){
      var a = courseData.data().values.toList();
      a[0].forEach((k,v){
        if(k==course){
          v.forEach((name,slot){
            if(name==faculty){
              print(slot);
              for (var s in slot){
                slots.add(s);
              }
            }
          });
        }
      } );
    }
  }

// ##############################################################

  //DateTime _dateTime;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // final _titlecontroller = TextEditingController();
    // final _briefcontroller = TextEditingController();
    //
    // if (widget.title != null) {
    //   _titlecontroller.text = widget.title ?? "";
    // }
    // if (widget.brief != null) {
    //   _briefcontroller.text = widget.brief ?? "";
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Join Groups",
            style: TextStyle(
                fontFamily: 'ProximaNova', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
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
                      "Select Course code",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'ProximaNova'

                        //color: Colors.white,
                      ),
                    ),

                    DropdownButtonFormField<String>(
                      value: _course,
                      items: courses.map((String course) {
                        return DropdownMenuItem<String>(
                          value: course,
                          child: Text(course),
                        );
                      }).toList(),
                      // decoration: textInputDecoration,
                      onChanged: (val) => setState(() {
                        _course = val!;
                        getCourseFaculty(_course);
                        if(_course!='Choose Course'){
                          cCheck=true;
                        }
                      }),
                    ),

                    SizedBox(height: 20.0),

                    const Text(
                      "Select Faculty",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'ProximaNova'

                        //color: Colors.white,
                      ),
                    ),

                    DropdownButtonFormField<String>(
                      // value: _faculty,
                      // decoration: textInputDecoration,

                      items: faculties.map((String faculty) {
                        return DropdownMenuItem<String>(
                          value: faculty,
                          child: Text(faculty),
                        );
                      }).toList(),
                      // onChanged: (val) => setState(() => _faculty = val!),
                      onChanged: (val) => setState(() {
                        _faculty = val!;
                        getCourseFacultySlot(_course,_faculty);
                        if(_faculty!='Choose Faculty'){
                          fCheck=true;
                        }
                      }),
                    ),

                    SizedBox(height: 20.0),

                    const Text(
                      "Select Slot",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'ProximaNova'

                        //color: Colors.white,
                      ),
                    ),


                    DropdownButtonFormField<String>(
                      value: _slot,
                      // decoration: textInputDecoration,
                      items: slots.map((String slot) {
                        return DropdownMenuItem<String>(
                          value: slot,
                          child: Text(slot),
                        );
                      }).toList(),
                      // onChanged: (val) => setState(() => _slot = val!),
                      onChanged: (val) => setState(() {
                        _slot = val!;
                        if(_slot!='Choose Slot'){
                          sCheck=true;
                        }
                      }),
                    ),

                    SizedBox(height: 60.0),

                    GestureDetector(
                      onTap: () async {
                        print(_faculty);
                        print(_slot);
                        print(_course);
                        if (cCheck&&fCheck&&sCheck) {
                          _firestore.collection('user').add({
                            'course': _course,
                            'email': loggedInUser.email, //from firebase
                            'faculty':_faculty,
                            'slot':_slot,
                          });
                          Navigator.pop(context);
                          MaterialPageRoute(builder: (context) => GroupPage());
                        }
                      },

                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.blue),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              "Join Group",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontFamily: 'ProximaNova'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // RaisedButton(
                    //     color: Colors.pink[400],
                    //     child: Text(
                    //       'Join',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     onPressed: () async {
                    //       print(_faculty);
                    //       print(_slot);
                    //       print(_course);
                    //       if (cCheck&&fCheck&&sCheck) {
                    //         _firestore.collection('user').add({
                    //           'course': _course,
                    //           'email': loggedInUser.email, //from firebase
                    //           'faculty':_faculty,
                    //           'slot':_slot,
                    //         });
                    //         Navigator.pop(context);
                    //         MaterialPageRoute(builder: (context) => GroupPage());
                    //       }
                    //     }
                    // ),
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

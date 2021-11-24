import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'groups.dart';

class Formz extends StatefulWidget {
  // const Formz({ required Key key }) : super(key: key);

  @override
  _FormzState createState() => _FormzState();
}

class _FormzState extends State<Formz> {

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




  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Join New Group',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _course,
                // decoration: textInputDecoration,
                items: courses.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (val) => setState(() {
                  _course = val!;
                  getCourseFaculty(_course);
                  if(_course!='Choose Course'){
                    cCheck=true;
                  }


                }),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                // value: _faculty,
                // decoration: textInputDecoration,
                items: faculties.map((faculty) {
                  return DropdownMenuItem(
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
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                // value: _slot,
                // decoration: textInputDecoration,
                items: slots.map((slot) {
                  return DropdownMenuItem(
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
              SizedBox(height: 10.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Join',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
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
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

}
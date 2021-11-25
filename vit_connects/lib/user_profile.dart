import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vit_connects/groups.dart';
import 'package:vit_connects/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vit_connects/profile.dart';
import 'package:vit_connects/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vit_connects/signinpage.dart';
import 'package:vit_connects/signup_controller.dart';

class User_Profile extends StatefulWidget {
  User_Profile({Key? key}) : super(key: key);

  @override
  _User_ProfileState createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
  final _auth = FirebaseAuth.instance;
  late User? loggedInUser;
  String? photo;
  String? displayName;

  final _firestore = FirebaseFirestore.instance;
  String takename(String ema) {
    String name = '';
    int a = 0;
    while (ema[a] != '2') {
      if (ema[a] == '.') {
        name = name + " ";
      } else {
        name = name + ema[a];
      }
      a++;
    }
    return name;
  }

  //late GoogleSignInAccount account;
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
        print(loggedInUser!.email);
      } else {
        print('no user found');
      }
    } catch (e) {
      print(e);
    }
  }

  // currentUser() {
  //   final User? user = _auth.currentUser;
  //   final uid = user!.uid.toString();
  //   return uid;
  // }

  @override
  Widget _button(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: MaterialButton(
        elevation: 0,
        height: 60,
        onPressed: () async {
          if (text == 'To Do') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          } else if (text == 'Groups') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GroupPage()),
            );
          } else if (text == 'Sign Out') {
            _auth.signOut();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
            print('user logged out');
          }
          //startSignIn();
          //if (_formKey.currentState.validate()) {
          // print(email);
          // print(password);
          //dynamic result = await _auth.registerWithEmail(email, password);
          //if (result == null) {
          //setState(() => {error = 'Please supply a valid email'});
          //}
          //}
        },
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 28, color: Colors.white, fontFamily: 'Red Rose'),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('registeredUsers').snapshots(),
              builder: (context, snapshot) {
                final messages = snapshot.data!.docs;
                int n = 0;
                for (var msg in messages) {
                  if (msg['email'] == loggedInUser!.email) {
                    return display(context, msg['photoUrl'], msg['displayName'],
                        loggedInUser!.email.toString());
                  }
                }
                // if (snapshot.connectionState == ConnectionState.done) {
                //   return display(context, snapshot);
                // } else {
                //   return CircularProgressIndicator();
                // }
                return CircularProgressIndicator();
              },
            ),
            Center(
              //SizedBox(height: 60),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 60),
                  _button("To Do"),
                  SizedBox(height: 30),
                  _button("Groups"),
                  SizedBox(height: 30),
                  _button("Sign Out"),
                  SizedBox(height: 30),
                ],
              ),
            ),
            SizedBox(height:35.0),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Image.asset(
                    'assets/images/icon.png',
                    height: 50,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'VIT-Connect\'s',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.red,
                        fontFamily: 'Work Sans'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget display(context, final photo, final displayName, String email) {
  //final user = snapshot.data;
  // String split(String displayName, int a) {
  //   String ok = '';
  //   if (a == 0) {
  //     while (displayName[a] != '1' || displayName[a] != '2') {
  //       ok += displayName[a++];
  //     }
  //   } else {
  //     while (displayName[a] != ' ') {
  //       ok = displayName[a--] + ok;
  //     }
  //   }
  //   return ok;
  // }

  return Column(
    children: <Widget>[
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(10.0),
        //ClipRRect(
        //borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          photo,
          height: 100,
        ),
        //),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          displayName.split(' ')[0] + " " + displayName.split(' ')[1],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.red,
              fontFamily: 'Work Sans'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          displayName.split(' ')[2],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 28, color: Colors.red, fontFamily: 'Work Sans'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          //late User? loggedInUser;
          email,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 20, color: Colors.red
              , fontFamily: 'Work Sans'),
        ),
      ),
    ],
  );
}

Widget displayUserInformation(context, snapshot) {
  final user = snapshot.data;

  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Name: ${user.displayName ?? 'Anonymous'}",
          style: TextStyle(fontSize: 20),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Email: ${user.email ?? 'Anonymous'}",
          style: TextStyle(fontSize: 20),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Created: ${DateFormat('MM/dd/yyyy').format(user.metadata.creationTime)}",
          style: TextStyle(fontSize: 20),
        ),
      ),

      // showSignOut(context, user.isAnonymous),
    ],
  );
}

class CircularImage extends StatelessWidget {
  final String imagePath;

  CircularImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.red, width: 10.0, style: BorderStyle.solid),
          image: new DecorationImage(
              fit: BoxFit.cover, image: AssetImage(imagePath))),
    );
  }
}

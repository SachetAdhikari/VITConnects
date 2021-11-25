import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vit_connects/groups.dart';
import 'package:vit_connects/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vit_connects/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vit_connects/signup_controller.dart';

class User_Profile extends StatefulWidget {
  User_Profile({Key? key}) : super(key: key);

  @override
  _User_ProfileState createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
  final _auth = FirebaseAuth.instance;
  late User? loggedInUser;
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

  currentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid.toString();
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: bg2,
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [],
      ),
      backgroundColor: bg,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90,
              ),
              // Image.network(
              //   account.photoUrl,
              //   height: 100,
              // ),
              Text(
                //currentUser(),
                takename(loggedInUser!.email.toString()),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28, color: Colors.white, fontFamily: 'Work Sans'),
              ),
              SizedBox(
                height: 300,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Created: ${DateFormat('MM/dd/yyyy').format(currentUser().metadata.creationTime)}",
              //     style: TextStyle(fontSize: 20),
              //   ),
              // ),
              //_button('Chat'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
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

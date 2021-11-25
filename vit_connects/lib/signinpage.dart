import 'package:flutter/material.dart';
import 'package:vit_connects/groups.dart';
import 'package:vit_connects/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vit_connects/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vit_connects/signup_controller.dart';
import 'package:vit_connects/user_profile.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

final Color cc = Color(0xFFC4C4C4);

class _SignInPageState extends State<SignInPage> {
  final _auth = FirebaseAuth.instance;
  @override
  void showAlert(BuildContext context, String title, String content) {
    print('Alert');
    var alertDialogue = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        // FloatingActionButton(onPressed: onPressed)Action(child: Text('Ok'),),
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
        )
      ],
      elevation: 24.0,
    );
    showDialog(
      context: context,
      builder: (_) => alertDialogue,
      barrierDismissible: false,
    );
  }

  final controller = Get.put(SignupController());

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  Widget _button(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        elevation: 0,
        height: 60,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => User_Profile()),
          );
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
        color: pc,
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: size.height * 0.13),
              Container(
                width: MediaQuery.of(context).size.width - 70,
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(children: <Widget>[
                  const SizedBox(height: 30),
                  const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontFamily: 'ProximaNova',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(right: 150, top: 10),
                          child: Text(
                            'Username',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25.0, left: 25.0, bottom: 20.0, top: 5.0),
                          child: TextFormField(
                            //validator: (val) => val.isEmpty ? 'Enter an Email' : null,

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),

                              //labelText: 'Username',
                              hintText: 'Username',
                              //fillColor: cc,
                              //hoverColor: cc,
                              //focusColor: cc,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() => email = value);
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 150),
                          child: Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25.0, left: 25.0, bottom: 30.0, top: 5.0),
                          child: TextFormField(
                            //validator: (val) =>
                            //  val.length < 8 ? 'Passcode must be 6+' : null,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              //labelText: 'Password',
                              hintText: 'Password',
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() => password = value);
                            },
                          ),
                        ),
                        Material(
                          color: Colors.red,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupPage()),
                                  );
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            minWidth: 250.0,
                            height: 60.0,
                            child: const Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "ProximaNova",
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        // ElevatedButton.icon(
                        //   style: ElevatedButton.styleFrom(
                        //     primary: pc,
                        //     onPrimary: Colors.white,
                        //     minimumSize: Size(250, 60),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //   ),
                        //   icon: const FaIcon(
                        //     FontAwesomeIcons.google,
                        //     color: Colors.red,
                        //   ),
                        //   label: Text('Login'),
                        //   onPressed: () {
                        //     print(email);
                        //     print(password);
                        //
                        //   },
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              onPrimary: Colors.white,
                              minimumSize: Size(250, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            label: const Text('Sign Up With Google',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "ProximaNova",
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {
                              controller.login();

                              print('google auth successfull');

                              String emailz =
                                  controller.googleAccount.value?.email ?? '';
                              String displayName =
                                  controller.googleAccount.value?.displayName ??
                                      '';
                              String photoUrl =
                                  controller.googleAccount.value?.photoUrl ??
                                      '';
                              String gID =
                                  controller.googleAccount.value?.id ?? '';

                              print(emailz +
                                  ' ' +
                                  displayName +
                                  ' ' +
                                  photoUrl +
                                  ' ' +
                                  gID);

                              // String emailz='sachet.adhikari2019@vitstudent.ac.in';

                              List isVitian = emailz.split('@');
                              if (isVitian[1] == 'vitstudent.ac.in') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                            email: emailz,
                                            displayName: displayName,
                                            photoUrl: photoUrl,
                                            gID: gID,
                                          )),
                                );
                                controller.logout();
                                print('logged out');
                              } else {
                                showAlert(context, 'Not VITian?',
                                    'Looks Like You are not VITian. To continue using the app, signup with your VIT mail!');
                                controller.logout();
                                print('logged out');
                              }
                            })
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

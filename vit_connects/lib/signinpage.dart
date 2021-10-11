import 'package:flutter/material.dart';
import 'package:vit_connects/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

final Color cc = Color(0xFFC4C4C4);

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  Widget _button(String textt) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        elevation: 0,
        height: 60,
        onPressed: () async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 70, bottom: 130, left: 35),
          child: Container(
            width: MediaQuery.of(context).size.width - 70,
            height: MediaQuery.of(context).size.height - 30,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(63.0),
                topRight: Radius.circular(63.0),
                bottomLeft: Radius.circular(63.0),
                bottomRight: Radius.circular(63.0),
              ),
            ),
            child: Column(children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Log In',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 46.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 200, top: 10),
                      child: Text(
                        'Username',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 25.0, left: 25.0, bottom: 20.0, top: 5.0),
                      child: TextFormField(
                        //validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //labelText: 'Username',
                          hintText: 'Username',
                          //fillColor: cc,
                          //hoverColor: cc,
                          //focusColor: cc,
                        ),

                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 25.0, left: 25.0, bottom: 30.0, top: 5.0),
                      child: TextFormField(
                        //validator: (val) =>
                        //  val.length < 8 ? 'Passcode must be 6+' : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //labelText: 'Password',
                          hintText: 'Password',
                        ),
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    _button('Log In'),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: pc,
                        onPrimary: Colors.white,
                        minimumSize: Size(250, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      label: Text('Sign Up With Google'),
                      onPressed: () {
                        // final provider = Provider.of<GoogleSignInProvider>(
                        //     context,
                        //     listen: false);
                        // provider.googleLogin();
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

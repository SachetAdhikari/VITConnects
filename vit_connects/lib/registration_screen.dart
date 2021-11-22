import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vit_connects/groups.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String password='';
  String cPassword='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password=value;
              },
              decoration: const InputDecoration(
                hintText: 'Setup Password for Vitconnects App',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                cPassword=value;
              },
              decoration: const InputDecoration(
                hintText: 'Confirm password',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async{
                    if(password==cPassword){
                      try {
                        final newUser = await _auth
                            .createUserWithEmailAndPassword(
                            email: widget.email, password: password);
                        if(newUser!=null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()),);
                        }
                      }
                      catch(e){
                        print(e);
                      }
                    }
                    else{
                      //raise error for password and cPassword mismatch
                    }

                    },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:vit_connects/signinpage.dart';
import './landingpage.dart';
import './groups.dart';
import 'package:firebase_core/firebase_core.dart';

import 'forms.dart';

void main() {
  runApp(VitConnects());
}

const Color bg = Color(0xffA49F9F);
const Color pc = Color(0xff100202);
const Color buttonc = Color(0xff2EF31D);
const Color bc = Color.fromARGB(255, 103, 137, 131);

class VitConnects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('error in firebase initialization');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('firebase initialization complete');
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "VIT CONNECTS",
          routes: {
            '/': (_) => LandingPage(),
            '/signinpage': (_) => SignInPage(),
            '/groups': (_) => GroupPage(),
            // './join': (_) => Formz(),
            //'/chat': (_) => ChatScreen(),
          },
        );
      },
    );
  }

  // Widgetet build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: "VIT CONNECTS",
  //     routes: {
  //       '/': (_) => LandingPage(),
  //       '/signinpage': (_) => SignInPage(),
  //       '/groups': (_) => GroupPage(),
  //       './join': (_) => Forms(),
  //       '/register': (_) => RegistrationScreen(),
  //     },
  //   );
  // }
}

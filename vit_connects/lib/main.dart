import 'package:flutter/material.dart';
import 'package:vit_connects/signinpage.dart';
import './landingpage.dart';
import './form.dart';
import './groups.dart';

void main() {
  runApp(VitConnects());
}

final Color bg = Color(0xffA49F9F);
final Color pc = Color(0xff100202);
final Color buttonc = Color(0xff2EF31D);
final Color bc = Color.fromARGB(255, 103, 137, 131);

class VitConnects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VIT CONNECTS",
      routes: {
        '/': (_) => LandingPage(),
        '/signinpage': (_) => SignInPage(),
        '/groups': (_) => GroupPage(),
        './join': (_) => Forms(),
      },
    );
  }
}

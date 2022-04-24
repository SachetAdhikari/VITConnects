import 'package:flutter/material.dart';
import 'package:vit_connects/main.dart';
import './signinpage.dart';
import './form.dart';

class LandingPage extends StatelessWidget {
  Widget _button(String textt, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        margin: const EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20, color: Colors.blue, fontFamily: 'ProximaNova'),
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
      backgroundColor: Colors.lightBlue,
      body: Column(
        children: [
          Container(
            height: size.height * 0.30,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: const [
                      // Padding(
                      //     padding: EdgeInsets.only(right: 20.0),
                      //      icon: ImageIcon(
                      //         AssetImage("images/icon.png"),
                      //         size: 4,),
                      //     )
                      // ),
                      //
                      Text(
                        "WELCOME",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "ProximaNova"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "TO",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "ProximaNova"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "VIT CONNECT's",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "ProximaNova"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
          _button("GET STARTED", context),
        ],
      ),
    );
  }
}

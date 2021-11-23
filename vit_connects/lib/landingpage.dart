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
        height: 80,
        decoration: BoxDecoration(
            color: buttonc,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        margin: const EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textt,
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
      backgroundColor: bg,
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.6265,
            margin: EdgeInsets.fromLTRB(0, size.height * 0.3735, 0, 0),
            decoration: BoxDecoration(
              color: pc,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: const [
                            Text(
                              "WELCOME",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
                              ),
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
                              ),
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
          ),
        ],
      ),
    );
  }
}

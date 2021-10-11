import 'package:flutter/material.dart';
import 'package:vit_connects/main.dart';
import './signinpage.dart';

class LandingPage extends StatelessWidget {
  Widget _button(String textt, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        elevation: 0,
        height: 80,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        },
        color: buttonc,
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
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6265,
            margin: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height * 0.3735, 0, 0),
            decoration: BoxDecoration(
              color: pc,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      '\nWELCOME\nTO\nVITCONNECTS',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                _button("GET STARTED", context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

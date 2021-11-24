import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vit_connects/profile.dart';
import 'package:vit_connects/groups.dart';
import 'package:vit_connects/signinpage.dart';
import './main.dart';

class SideMenu extends StatelessWidget {
  //const SideMenu({ Key? key }) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                'VIT Connects',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'ProximaNova'),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.verified_user,
                color: Colors.red,
              ),
              title: const Text('Profile',
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {
                    //Navigator.of(context).pop()
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    ),
                  }),
          ListTile(
              leading: const Icon(
                Icons.checklist_rounded,
                color: Colors.red,
              ),
              title: const Text("To-Do lists",
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                ),
              }),
          ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.red,
              ),
              title: const Text("Chat Rooms",
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupPage()),
                ),
              }),
          ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: const Text('Log Out',
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: (){

    _auth.signOut();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
    print('user logged out');
                }
          )],
      ),
    );
  }
}

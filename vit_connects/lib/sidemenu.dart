import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './main.dart';

class SideMenu extends StatelessWidget {
  //const SideMenu({ Key? key }) : super(key: key);

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
              onTap: () => {Navigator.of(context).pop()}),
          ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.red,
              ),
              title: const Text('Settings',
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {Navigator.of(context).pop()}),
          ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: const Text('Log Out',
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {Navigator.of(context).pop()}),
        ],
      ),
    );
  }
}

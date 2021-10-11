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
          DrawerHeader(
            child: Text(
              'Welcome!!!',
              style: TextStyle(
                  fontSize: 32, color: Colors.white, fontFamily: 'Red Rose'),
            ),
            decoration: BoxDecoration(
              color: pc,
            ),
          ),
          ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {Navigator.of(context).pop()}),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {Navigator.of(context).pop()}),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () => {Navigator.of(context).pop()}),
        ],
      ),
    );
  }
}

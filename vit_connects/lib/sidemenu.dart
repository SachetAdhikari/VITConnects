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
            child: const Center(
              child: const Text(
                'Welcome!!!',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'ProximaNova'),
              ),
            ),
            decoration: BoxDecoration(
              color: pc,
            ),
          ),
          ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Profile',
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {Navigator.of(context).pop()}),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings',
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {Navigator.of(context).pop()}),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log Out',
                  style: TextStyle(fontFamily: 'ProximaNova', fontSize: 17)),
              onTap: () => {Navigator.of(context).pop()}),
        ],
      ),
    );
  }
}

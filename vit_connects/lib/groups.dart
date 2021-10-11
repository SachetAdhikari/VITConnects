import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:draggable_fab/draggable_fab.dart';
import './main.dart';
import './form.dart';

//import './sidemenu.dart';
class GroupPage extends StatefulWidget {
  GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  //FloatingActionButtonLocation _fabLocation =
  //FloatingActionButtonLocation.centerFloat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: SizedBox(
      //   height: 100,
      //   width: 100,
      //   child: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      //     onPressed: () {},
      //   ),
      // ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: buttonc,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Forms()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      drawer: Drawer(
          //child: SideMenu())
          ),
      appBar: AppBar(
        backgroundColor: pc,
        title: Text("Groups"),
        leading: IconButton(
          icon: Icon(
            Icons.list_outlined,
          ),
          onPressed: () {},
        ),
      ),
      //floatingActionButton: FloatingActionButtonLocation.centerFloat,
    );
  }
}

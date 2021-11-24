import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:vit_connects/custom_card.dart';
import 'package:vit_connects/form.dart';
import 'package:vit_connects/groups.dart';
import 'package:vit_connects/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vit_connects/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:vit_connects/sidemenu.dart';
import 'package:vit_connects/signup_controller.dart';
import 'package:vit_connects/todo_form.dart';
import 'chat_screen.dart';
import 'groups.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      } else {
        print('no user found');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        floatingActionButton: DraggableFab(
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Formss()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        drawer: Drawer(child: SideMenu()),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("To Do",
              style: TextStyle(
                  fontFamily: 'ProximaNova', fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('ToDo').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  // final messages = snapshot.data!.docs.reversed;
                  final user_details = snapshot.data!.docs;
                  List<Widget> groups = [];
                  for (var message in user_details) {
                    // final messageText = message.data['text'];
                    final email = message['email'];
                    if (email == loggedInUser.email) {
                      final title = message['title'];
                      final description = message['description'];
                      //showCard(context, title, description, 'date', 'time');
                      //final user_detailss = GroupList(title: title, description: description);
                      groups.add(showCard(context, title, description, 'date',
                          'time', _firestore));
                    }
                    //final messageSender = message[''];
                    //final sentTime = message['time'];

                    //final currentUser = loggedInUser.email;
                    // final messageBubble = MessageBubble(
                    //     sender: messageSender,
                    //     text: messageText,
                    //     time: sentTime.toDate(),
                    //     isMe: currentUser == messageSender);
                    // messageBubbles.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      //reverse: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: groups,
                    ),
                  );

                  return Container();
                },
              ),
            ],
          ),
        )
        //floatingActionButton: FloatingActionButtonLocation.centerFloat,
        );
  }
}

class GroupList extends StatelessWidget {
  const GroupList({Key? key, required this.title, required this.description})
      : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'ProximaNova'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

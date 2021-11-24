import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/painting.dart';
import 'package:vit_connects/chat_screen.dart';
import './main.dart';
import './form.dart';
import './sidemenu.dart';
import 'custom_card.dart';

//import './sidemenu.dart';
class GroupPage extends StatefulWidget {
  GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  //FloatingActionButtonLocation _fabLocation =
  //FloatingActionButtonLocation.centerFloat;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  final _firestore = FirebaseFirestore.instance;
  Widget _button(String textt, BuildContext context, String coursename,
      String faculty, String slot) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        elevation: 0,
        height: 80,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      course: coursename,
                      faculty: faculty,
                      slot: slot,
                    )),
          );
        },
        color: buttonc,
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
                MaterialPageRoute(builder: (context) => Forms()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        drawer: Drawer(child: SideMenu()),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Groups",
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
              //showCard(context, "title", "Desc", "date", "time"),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('user').snapshots(),
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
                  List<GroupList> groups = [];
                  for (var message in user_details) {
                    // final messageText = message.data['text'];
                    final email = message['email'];
                    if (email == loggedInUser.email) {
                      final course = message['course'];
                      final faculty = message['faculty'];
                      final slot = message['slot'];
                      final user_detailss = GroupList(
                        coursename: course,
                        slot: slot,
                        faculty: faculty,
                      );
                      groups.add(user_detailss);
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
                      padding: EdgeInsets.symmetric(
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
  const GroupList(
      {Key? key,
      required this.coursename,
      required this.slot,
      required this.faculty})
      : super(key: key);
  final String coursename;
  final String slot;
  final String faculty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      course: coursename,
                      faculty: faculty,
                      slot: slot,
                    )),
          );
        },
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Text(
              coursename + " " + slot,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 28, color: Colors.white, fontFamily: 'ProximaNova'),
            ),
          ),
        ),
      ),
    );
  }
}

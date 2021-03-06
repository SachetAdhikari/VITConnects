import 'package:flutter/material.dart';
import 'package:vit_connects/signinpage.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({required this.course, required this.faculty, required this.slot});
  String course = '';
  String faculty= '';
  String slot= '';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  final _firestore = FirebaseFirestore.instance;
  String messageText = '';

  final messageTextController = TextEditingController();

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

//   void getMessages() async{
//     final messages = await _firestore.collection('messages').get();
//     for(var message in messages.docs){
//       print(message.data());
//     }
// }

  // void messagesStream() async{
  //   await for(var snapshots in _firestore.collection('messages').snapshots()){
  //     for(var message in snapshots.docs){
  //       print(message.data());
  //     }
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    final String collectionName = widget.course+widget.slot+widget.faculty;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
        title:  Text(widget.course+' ['+widget.slot+']'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(collectionName)
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
                // final messages = snapshot.data!.docs.reversed;
                final messages = snapshot.data!.docs;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages) {
                  // final messageText = message.data['text'];
                  final messageText = message['text'];
                  final messageSender = message['sender'];
                  final sentTime = message['time'];

                  final currentUser = loggedInUser.email;

                  final messageBubble = MessageBubble(
                      sender: messageSender,
                      text: messageText,
                      time: sentTime.toDate(),
                      isMe: currentUser == messageSender);
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                );

                return Container();
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (messageText != null) {
                        _firestore.collection(collectionName).add({
                          'text': messageText,
                          'sender': loggedInUser.email, //from firebase
                          'time': DateTime.now(),
                        });
                        messageTextController.clear();
                      }
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {required this.sender,
      required this.text,
      required this.isMe,
      required this.time});
  final String sender;
  final String text;
  final DateTime time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final String datetime = convertDateTime(time);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender.split('@')[0],
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            color: isMe ? Colors.lightBlue : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Text(
            datetime,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  static String convertDateTime(DateTime d) {
    // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat dateFormat = DateFormat("HH:mm");
    String dateTime = dateFormat.format(d);
    return dateTime;
  }
}

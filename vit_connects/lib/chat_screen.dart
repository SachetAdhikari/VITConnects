import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  final _firestore = FirebaseFirestore.instance;
  String messageText='';

  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final user= await _auth.currentUser;
      if(user != null){
        loggedInUser=user;
        print(loggedInUser.email);
      }
      else{
        print('no user found');
      }
    }
    catch(e){
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
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {

                // messagesStream();

               _auth.signOut();
               Navigator.pop(context);
               print('user logged out');
              }),
        ],
        title: const Text('️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                    final messages = snapshot.data!.docs.reversed;
                    List<MessageBubble> messageBubbles =[];
                    for (var message in messages){
                      // final messageText = message.data['text'];
                      final messageText = message['text'];
                      final messageSender = message['sender'];

                      final currentUser = loggedInUser.email;

                      final messageBubble = MessageBubble(sender: messageSender, text: messageText,
                      isMe: currentUser==messageSender);
                      messageBubbles.add(messageBubble);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                        children: messageBubbles,
                      ),
                    );

                  return Container();
                },),
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
                      _firestore.collection('messages').add({
                        'text':messageText,
                        'sender':loggedInUser.email,
                        'time':Timestamp.now(),
                      });
                      messageTextController.clear();
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
  const MessageBubble({required this.sender,required this.text, required this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: <Widget> [
        Text(sender,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
         Material(
          elevation: 5.0,
          borderRadius:isMe? BorderRadius.only(topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0)): BorderRadius.only(topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
          color: isMe? Colors.lightBlue: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            child: Text('$text',
              style:  TextStyle(
                color: isMe? Colors.white: Colors.black54,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        ]  ,
      ),
    );
  }
}

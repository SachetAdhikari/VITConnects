// Function for Cards

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'todo_form.dart';

Widget showCard(BuildContext context, String title, String subTitle,
    String date, String time, final _firestore) {
  return Container(
      height: 110,
      color: Colors.red,
      child: Card(
        elevation: 8,
        color: Colors.white,
        child: ListTile(
          trailing: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Formss(
                              title: title,
                              brief: subTitle,
                            )));
                  },
                  icon: const Icon(
                    Icons.edit_rounded,
                  ),
                  color: Colors.red,
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('ToDo')
                          //.orderBy('time', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.blueAccent,
                            ),
                          );
                        }
                        final messages = snapshot.data!.docs;
                        for (var msg in messages) {
                          final titles = msg['title'];
                          if (title == titles) {
                            msg.reference.delete();
                          }
                        }
                        return Container();
                      },
                    );
                    //await _firestore.instance.collection('ToDo').document();
                  },
                  icon: const Icon(Icons.delete_rounded),
                  color: Colors.red,
                ),
              ],
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          subtitle: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subTitle,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text("Date: " + date),
                      const SizedBox(
                        width: 20,
                      ),
                      Text("Time: " + time)
                    ],
                  )
                ],
              )),
        ),
      ));
}

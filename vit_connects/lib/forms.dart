// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import './main.dart';
// import 'constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class Forms extends StatefulWidget {
//   Forms({Key? key}) : super(key: key);

//   @override
//   _FormsState createState() => _FormsState();
// }

// class _FormsState extends State<Forms> {
//   late User loggedInUser;
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final _formKey = GlobalKey<FormState>();
//   List<String> coursename = ['SE', 'ISAA', 'DSA'];
//   //final datum = snapshot.data!.docs;
//   String? course = 'SE';
//   List<String> coursecode = ['CSE3001', 'CSE3009', 'CSE3004'];
//   String? coursec = 'CSE3001';
//   List<String> facultyname = ['Sachet', 'Ankit', 'Subham'];
//   String? faculty = 'Subham';
//   List<String> slot = ['A1', 'B1', 'C1'];
//   String? s = 'A1';
//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   void getCurrentUser() async {
//     try {
//       final user = await _auth.currentUser;
//       if (user != null) {
//         loggedInUser = user;
//         print(loggedInUser.email);
//       } else {
//         print('no user found');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Widget _button(String textt, BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 60),
//       child: MaterialButton(
//         elevation: 0,
//         height: 60,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Forms()),
//           );
//         },
//         color: bc,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               textt,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   fontSize: 28, color: Colors.white, fontFamily: 'ProximaNova'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(
//         title: const Text("VIT CONNECT's",
//             style: TextStyle(fontFamily: 'ProximaNova')),
//         backgroundColor: pc,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 // StreamBuilder<QuerySnapshot>(
//                 //   stream: _firestore.collection('courses').snapshots(),
//                 //   builder: (context, snapshot) {
//                 //     if (!snapshot.hasData) {
//                 //       return const Center(
//                 //         child: CircularProgressIndicator(
//                 //           backgroundColor: Colors.blueAccent,
//                 //         ),
//                 //       );
//                 //     }
//                 //     final courses = snapshot.data!.docs;
//                 //     for (var datum in courses) {
//                 //       final faculty1 = datum['faculty'];
//                 //       final coursecode1 = datum['id'];
//                 //       final coursename1 = datum['name'];
//                 //       facultyname = faculty1.keys.toList();
//                 //       coursecode.add(coursecode1);
//                 //       print(coursecode1);
//                 //       print(facultyname);
//                 //       print(coursename1);
//                 //       coursename.add(coursename1);
//                 //       //slot.add();
//                 //     }
//                 //     return Container();
//                 //   },
//                 //),
//                 const Text(
//                   "Course Name",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
//                       //color: Colors.white,
//                       ),
//                 ),
//                 Container(
//                   width: 400,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 4),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       value: course,
//                       isExpanded: true,
//                       iconSize: 36,
//                       icon: const Icon(Icons.arrow_drop_down,
//                           color: Colors.black),
//                       items: coursename.map(buildMenuItem).toList(),
//                       onChanged: (value) => setState(() => course = value),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   "Course Code",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'

//                       //color: Colors.white,
//                       ),
//                 ),
//                 Container(
//                   width: 400,
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 4),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       value: coursec,
//                       isExpanded: true,
//                       iconSize: 36,
//                       icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                       items: coursecode.map(buildMenuItem).toList(),
//                       onChanged: (value) => setState(() => coursec = value),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   "Slot",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
//                       //color: Colors.white,
//                       ),
//                 ),
//                 Container(
//                   width: 400,
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 4),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       value: s,
//                       isExpanded: true,
//                       iconSize: 36,
//                       icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                       items: slot.map(buildMenuItem).toList(),
//                       onChanged: (value) => setState(() => s = value),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   "Faculty Name",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
//                       //color: Colors.white,
//                       ),
//                 ),
//                 Container(
//                   width: 400,
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 4),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       value: course,
//                       isExpanded: true,
//                       iconSize: 36,
//                       icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                       items: facultyname.map(buildMenuItem).toList(),
//                       onChanged: (value) => setState(() => faculty = value),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 _button("Join", context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//         value: item,
//         child: Text(
//           item,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       );
// }

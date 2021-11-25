import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vit_connects/form.dart';
import './main.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// For changing the language
//import 'package:flutter_localizations/flutter_localizations.dart';

class Formss extends StatefulWidget {
  String? title; //optional paremeters
  String? brief;
  DateTime? dt;
  Formss({Key? key, this.title, this.brief, this.dt}) : super(key: key);

  @override
  _FormssState createState() => _FormssState();
}

class _FormssState extends State<Formss> {
  DateTime? _dateTime;
  //DateTime? now;
  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  String title = '';
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String description = '';
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

  //DateTime _dateTime;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final _titlecontroller = TextEditingController();
    final _briefcontroller = TextEditingController();

    if (widget.title != null) {
      _titlecontroller.text = widget.title ?? "";
    }
    if (widget.brief != null) {
      _briefcontroller.text = widget.brief ?? "";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("To Do Details",
            style: TextStyle(
                fontFamily: 'ProximaNova', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    // SizedBox(height: 24),
                    // Clock24Example(),
                    // SizedBox(height: 24),
                    // LocaleExample(),
                    // SizedBox(height: 24),
                    // BasicDateTimeField(),
                    // SizedBox(height: 24),
                    // IosStylePickers(),
                    // SizedBox(height: 24),
                    // ComplexDateTimeField(),
                    // SizedBox(height: 24),
                    Container(
                      height: size.height * 0.10,
                    ),
                    const Text(
                      "Title",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'
                          //color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _titlecontroller,
                      // onChanged: print("changed"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Title',
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Brief",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova'

                          //color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _briefcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Description',
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BasicDateTimeField(),
                    const SizedBox(height: 20),
                    //BasicTimeField(),
                    // Row(
                    //   children: <Widget>[
                    //     IconButton(
                    //       icon: Icon(Icons.date_range),
                    //       padding: EdgeInsets.zero,
                    //       onPressed: () {
                    //         showDatePicker(
                    //                 context: context,
                    //                 initialDate: _dateTime ?? DateTime.now(),
                    //                 firstDate: DateTime(2001),
                    //                 lastDate: DateTime(2025))
                    //             .then((date) {
                    //           setState(() {
                    //             _dateTime = date!;
                    //           });
                    //         });
                    //       },
                    //     ),
                    //     // RaisedButton(
                    //     //   child: Text('Pick a date'),
                    //     //   onPressed: () {
                    //     //     showDatePicker(
                    //     //             context: context,
                    //     //             initialDate: _dateTime ?? DateTime.now(),
                    //     //             firstDate: DateTime(2001),
                    //     //             lastDate: DateTime(2025))
                    //     //         .then((date) {
                    //     //       setState(() {
                    //     //         _dateTime = date!;
                    //     //       });
                    //     //     });
                    //     //   },
                    //     // ),
                    //     Text(_dateTime == null
                    //         ? "-----------"
                    //         : _dateTime.toString()),
                    //     //   // Expanded(
                    //     //   //   child: TextField(
                    //     //   //     decoration: InputDecoration(
                    //     //   //       hintText: 'Date Created',
                    //     //   //     ),
                    //     //   //     //readOnly:true, // Or wrap the input with AbsorbPointer if you do not want the field to get highlighted by taping on it
                    //     //   //   ),
                    //     //   // ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        //if (title != null) {
                        _firestore.collection('ToDo').add({
                          'title': title,
                          'email': loggedInUser.email, //from firebase
                          'description': description,
                          'dateNtime': DateTimeField,
                        });
                        //}
                        // titleController.clear();
                        // descriptionController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Formss()),
                        );
                      },
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.red),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Add Task",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontFamily: 'ProximaNova'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //_button("Join", context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Due Date'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Due Time'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return time == null ? null : DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Date and Time'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}

class IosStylePickers extends StatefulWidget {
  @override
  _IosStylePickersState createState() => _IosStylePickersState();
}

class _IosStylePickersState extends State<IosStylePickers> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? value;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('iOS style pickers (${format.pattern})'),
      DateTimeField(
        initialValue: value,
        format: format,
        onShowPicker: (context, currentValue) async {
          await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return BottomSheet(
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: CupertinoDatePicker(
                          onDateTimeChanged: (DateTime date) {
                            value = date;
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Ok')),
                    ],
                  ),
                  onClosing: () {},
                );
              });
          setState(() {});
          return value;
        },
      ),
    ]);
  }
}

class ComplexDateTimeField extends StatefulWidget {
  @override
  _ComplexDateTimeFieldState createState() => _ComplexDateTimeFieldState();
}

class _ComplexDateTimeFieldState extends State<ComplexDateTimeField> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  bool? readOnly = true;
  bool? showResetIcon = true;
  DateTime? value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Complex date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        autovalidateMode: autoValidateMode,
        validator: (date) => date == null ? 'Invalid date' : null,
        initialValue: initialValue,
        onChanged: (date) => setState(() {
          value = date;
          changedCount++;
        }),
        onSaved: (date) => setState(() {
          value = date;
          savedCount++;
        }),
        resetIcon: showResetIcon! ? Icon(Icons.delete) : null,
        readOnly: readOnly!,
        decoration: InputDecoration(
            helperText: 'Changed: $changedCount, Saved: $savedCount, $value'),
      ),
      CheckboxListTile(
        title: Text('autoValidate'),
        value: autoValidateMode != AutovalidateMode.disabled,
        onChanged: (value) =>
            setState(() => autoValidateMode = AutovalidateMode.always),
      ),
      CheckboxListTile(
        title: Text('readOnly'),
        value: readOnly,
        onChanged: (value) => setState(() => readOnly = value),
      ),
      CheckboxListTile(
        title: Text('showResetIcon'),
        value: showResetIcon,
        onChanged: (value) => setState(() => showResetIcon = value),
      ),
    ]);
  }
}

class Clock24Example extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('24 hour clock'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class LocaleExample extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Changing the pickers\' language'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) => Localizations.override(
              context: context,
              locale: Locale('zh'),
              child: child,
            ),
          );
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              builder: (context, child) => Localizations.override(
                context: context,
                locale: Locale('zh'),
                child: child,
              ),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}

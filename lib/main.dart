import 'dart:convert';

import 'package:app/dbhelper.dart';
import 'package:app/person.dart';
import 'package:flutter/material.dart';
import 'package:app/dbhelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(title: "", home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Db_helper _db;
  
  @override
  void initState(){
    super.initState();
    _db = Db_helper.instance;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: (() => addPeron(context)),
            child: const Text('Add Person'),
          )
        ],
      ),
    );
  }

  Future<void> addPeron(BuildContext context) {
    TextEditingController tid = TextEditingController();
    TextEditingController tname = TextEditingController();
    TextEditingController tage = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: AlertDialog(
            title: Text("Add New Person"),
            content: Column(
              children: [
                TextField(
                  controller: tid,
                  decoration: InputDecoration(hintText: "Person ID"),
                ),
                TextField(
                  controller: tname,
                  decoration: InputDecoration(hintText: "Person Name"),
                ),
                TextField(
                  controller: tage,
                  decoration: InputDecoration(hintText: "Person Age"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _db.insert2(person(id:tid.text as int, name: tname.text , age: tage.text as int));
                },
                child: const Text("save"),
              )
            ],
          ),
        );
      },
    );
  }
}

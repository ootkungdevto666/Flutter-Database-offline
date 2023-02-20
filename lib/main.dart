import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "";
  List<Map<String, dynamic>> Person_data = [
    {"id": 1, "name": "jirapas", "age": 23},
    {"id": 2, "name": "miyu", "age": 22},
    {"id": 3, "name": "sisbel", "age": 19},
    {"id": 4, "name": "jirapas", "age": 23},
    {"id": 5, "name": "miyu", "age": 22},
    {"id": 6, "name": "sisbel", "age": 19},
    {"id": 7, "name": "jirapas", "age": 23},
    {"id": 8, "name": "miyu", "age": 22},
    {"id": 9, "name": "sisbel", "age": 19},
  ];

  @override
  void initState() {
    super.initState();
    text = Person_data.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyHome"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text(""),
          ),
          SizedBox(
            height: 250,
            child: Column(
              children: [SingleChildScrollView(
                child: buildlist(),
              )],
            ),
          )
        ],
      ),
    );
  }

  Widget buildlist() {
    return Column(
      children: Person_data.map(
        (json) => Card(
          child: ListTile(
            title: Text("${json["id"]} : ${json["name"]}"),
            subtitle: Text("${json["age"]}"),
            trailing: Text("${json["age"]}"),
          ),
        ),
      ).toList(),
    );
  }
}

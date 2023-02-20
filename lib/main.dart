import 'package:app/dbhelper.dart';
import 'package:app/person.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

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
  late Db_helper _db;
  String text = "";
  List<Map<String, dynamic>> Person_data = [];
  /*
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
*/

  loaddata() async {
    Database db = await Db_helper.instance.database;
    Person_data = await db.query(Db_helper.table);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //text = Person_data.toString();
    loaddata();
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
          Column(
            children: [
              ElevatedButton(onPressed: () => todo(), child: Text("todo")),
              ElevatedButton(
                  onPressed: () => inputAlert(context),
                  child: Text("add person"))
            ],
          ),
          SizedBox(
            height: 250,
            child: SingleChildScrollView(
              child: buildlistJson(),
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

  Widget buildlistJson() {
    List<person> p = Person_data.map((json) => person.fromJson(json)).toList();
    return Column(
      children: p
          .map(
            (list) => Card(
              child: ListTile(
                title: Text("${list.id} : ${list.name}"),
                subtitle: Text("${list.age}"),
                trailing: Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        deletePerson(list.id);
                      }, 
                      icon: Icon(Icons.dangerous),
                      )
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void todo() async {
    Db_helper db = Db_helper.instance;
    person person_data = person(id: 4, name: "jirapas", age: 23);
    db.insert2(person_data.toJson());
    Person_data = await db.queryAllRow();
    setState(() {});
  }

  void insert(int id, String name, int age) async {
    Db_helper db = Db_helper.instance;
    person person_data = person(id: id, name: name, age: age);
    db.insert2(person_data.toJson());
    Person_data = await db.queryAllRow();
    setState(() {});
  }

  inputAlert(BuildContext context) {
    int Pid;
    String name;
    int Page;
    TextEditingController t1 = TextEditingController();
    TextEditingController t2 = TextEditingController();
    TextEditingController t3 = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Person data"),
            content: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
       
                TextField(
                  controller: t1,
                  decoration: InputDecoration(hintText: "input your id"),

                ),
            
                TextField(
                  controller: t2,
                  decoration: InputDecoration(hintText: "input your name"),

                ),
            
                TextField(
                  controller: t3,
                  decoration: InputDecoration(hintText: "input your age"),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: (() {
                    insert(int.parse(t1.text), t2.text, int.parse(t3.text));
                    Navigator.of(context).pop();
                  }),
                  child: Text("add")),
            ],
          );
        });
  }
  
  void deletePerson(int id) async{
    Db_helper db = Db_helper.instance;
    db.delete(id);
    Person_data = await db.queryAllRow();
    setState(() {});
  }
}

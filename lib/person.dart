import 'dart:convert';

// class personfields {
//   static final List<String> data = [id, name, age];
//   static const String id = '_id';
//   static const String name = 'name';
//   static const String age = 'age';
// }

// ignore: camel_case_types
class person {
  final int id;
  final String name;
  final int age;

  const person({required this.id, required this.name, required this.age});

  static final Map<String,dynamic> info ={
    "id":"id",
    "name":"name",
    "age":"age",
  };

  person copy({int? id,String? name,int? age})=>person(
    id:id ?? this.id, 
    name:name ?? this.name, 
    age: age ?? this.age
  );

  static person fromJson(Map<String, Object?> json) => person(
      id: json["id"] as int,
      name: json["name"] as String,
      age: json["age"] as int
  );

  Map<String , Object> toJson() => {
    info["id"]:id,
    info["name"]:name,
    info["age"]:age,
 };


}

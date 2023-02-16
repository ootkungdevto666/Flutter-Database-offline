import 'dart:convert';

class personfields {
  static final List<String> data = [id, name, age];
  static const String id = '_id';
  static const String name = 'name';
  static const String age = 'age';
}

class person {
  final int id;
  final String name;
  final int age;

  const person({required this.id, required this.name, required this.age});

  static person fromJson(Map<String, Object?> json) => person(
      id: json[personfields.id] as int,
      name: json[personfields.name] as String,
      age: json[personfields.age] as int
  );

  Map<String , Object> toJson() => {
    personfields.id :id,
    personfields.name:name,
    personfields.age:age,
  };


}

import 'dart:convert';

class persondields {
  static final List<String> data = [id, name, age];
  static const String id = 'id';
  static const String name = 'name';
  static const String age = 'age';
}

class person {
  final int id;
  final String name;
  final int age;

  const person({required this.id, required this.name, required this.age});

  static person fromJson(Map<String, Object?> json) => person(
      id: json[persondields.id] as int,
      name: json[persondields.name] as String,
      age: json[persondields.age] as int
  );

  Map<String , Object> toJson() => {
    persondields.id :id,
    persondields.name:name,
    persondields.age:age,
  };

  
}

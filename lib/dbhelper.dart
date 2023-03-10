import 'dart:io';
import 'package:app/person.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db_helper {
  static const _databaseName = "MyDb4.db";
  static final _databaseVersion = 1;
  static final table = 'person';
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnAge = 'age';

  Db_helper._privateConstructor();
  static final Db_helper instance = Db_helper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $table(
$columnId INTEGER PRIMARY KEY,
$columnName TEXT NOT NULL,
$columnAge INTEGER NOT NULL)
''');
  }

//old insert function
/* 
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }
*/

  Future<int> insert2(Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //get all
  Future<List<Map<String,dynamic>>> queryAllRow() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int?> queryRoundCount() async {
  Database db = await instance.database;
  return Sqflite.firstIntValue(
    await db.rawQuery("Select count(*) from $table")
  );
}

Future<int> update(Map<String, dynamic> row) async {
  Database db = await instance.database;
  int id = row[columnId];
  return await db.update(
    table,
    row,
    where: '$columnId= ?',
    whereArgs: [id],
  );
}

Future<int> delete(int id) async {
  Database db = await instance.database;
  return await db.delete(table,where: '$columnId=?',whereArgs:[id],);
}

}


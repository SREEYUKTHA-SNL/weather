import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbservice {
  static Database? database;
  Future<void> initialisedb() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'demo.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE locationtable (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, location TEXT, temperature TEXT,weather TEXT,time TEXT)');
    });
  }

  //add values
  Future<void> addvalues(
      {required String location,
      required String temperature,
      required String weather,
      required String time}) async {
    int a=await database!.insert(
      'locationtable',
      {'location': location, 'temperature': temperature, 'weather': weather,'time':time},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    

  }


  //get values
  Future<List> getvalues() async {
     final List<Map<String, Object?>> weatherlist = await database!.query('locationtable');
     return weatherlist;

  }
}

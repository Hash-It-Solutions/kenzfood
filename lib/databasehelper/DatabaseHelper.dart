import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import 'DatabaseTables.dart';





class DatabaseHelper {
  static final _databaseName = "kenzdata.db";
  static final _databaseVersion = 1;


  // only have a single app-wide reference to the database
  late Database _database;

  Future<Database> getdatabase() async {

    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE ' +
        DatabaseTables.History +
        ' (' +
        'keyid' +
        ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
        'data' +
        ' TEXT NOT NULL' +
        ')');

    await db.execute('CREATE TABLE ' +
        DatabaseTables.SmallBanner +
        ' (' +
        'keyid' +
        ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
        'data' +
        ' TEXT NOT NULL' +
        ')');

    await db.execute('CREATE TABLE ' +
        DatabaseTables.Bigbanner +
        ' (' +
        'keyid' +
        ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
        'data' +
        ' TEXT NOT NULL' +
        ')');

    await db.execute('CREATE TABLE ' +
        DatabaseTables.categories +
        ' (' +
        'keyid' +
        ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
        'data' +
        ' TEXT NOT NULL' +
        ')');

    await db.execute('CREATE TABLE ' +
        DatabaseTables.subcategories +
        ' (' +
        'keyid' +
        ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
        'categoryid' +
        ' TEXT NOT NULL , ' +
        'data' +
        ' TEXT NOT NULL' +
        ')');

    await db.execute('CREATE TABLE ' +
        DatabaseTables.products +
        ' (' +
        'keyid' +
        ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
        'categoryid ' +
        ' TEXT NOT NULL , ' +
        'data' +
        ' TEXT NOT NULL' +
        ')');


    await db.execute('CREATE TABLE ' +
        DatabaseTables.allproducts +
        ' (' +
        'keyid' +
        ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
        'data' +
        ' TEXT NOT NULL' +
        ')');


  }


  Future<int> insert(Map<String, dynamic> row,String tablename) async {
    Database db = await getdatabase();
    return await db.insert(tablename, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tablename) async {
    Database db = await getdatabase();
    return await db.query(tablename);
  }


  Future<int> deleteAll(String tablename) async {
    Database db = await getdatabase();
    return await db.delete(tablename);
  }



  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      // you can execute drop table and create table
      // db.execute("ALTER TABLE tb_name ADD COLUMN newCol TEXT;");

       db.execute('CREATE TABLE ' +
          DatabaseTables.SmallBanner +
          ' (' +
          'keyid' +
          ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
          'data ' +
          ' TEXT NOT NULL' +
          ')');

       db.execute('CREATE TABLE ' +
          DatabaseTables.Bigbanner +
          ' (' +
          'keyid' +
          ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
          'data ' +
          ' TEXT NOT NULL' +
          ')');

        db.execute('CREATE TABLE ' +
           DatabaseTables.categories +
           ' (' +
           'keyid' +
           ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
           'categoryid ' +
           ' TEXT NOT NULL , ' +
           'data ' +
           ' TEXT NOT NULL' +
           ')');

        db.execute('CREATE TABLE ' +
           DatabaseTables.subcategories +
           ' (' +
           'keyid' +
           ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
           'categoryid ' +
           ' TEXT NOT NULL , ' +
           'data ' +
           ' TEXT NOT NULL' +
           ')');

        db.execute('CREATE TABLE ' +
           DatabaseTables.products +
           ' (' +
           'keyid' +
           ' INTEGER PRIMARY KEY  AUTOINCREMENT , ' +
           'categoryid' +
           ' TEXT NOT NULL , ' +
           'data' +
           ' TEXT NOT NULL' +
           ')');

    }
  }
}
import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';
class DBHelper {
 static Database? _db;
 static const int _version=1;
 static const String _tableName='task';
  static Future <void>initDb() async
  {
    if(_db !=null)
      {
      debugPrint('not equal null');
      return;
      }
    else
      {
        try
        {
          var _path = await getDatabasesPath()+'task.db';
         debugPrint('in database path');
          _db= await openDatabase(_path, version: _version,
              onCreate: (Database db, int version) async {
                debugPrint('creating a new one ');
                // When creating the db, create the table
               return db.execute(
                    'CREATE TABLE $_tableName('
                        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                        'title STRING,note TEXT,date STRING,'
                        'isComplete INTEGER,'
                        'startTime STRING,'
                        'endTime STRING,'
                        'color INTEGER,'
                        'remind INTEGER,'
                        'repeat STRING,)');
              });
          print('database created ');
        }
        catch(e)
        {
          print(e);
        }
      }

  }
 static Future<int> insert(Task? task) async {
    print('; insert ');
    try{
   return await _db!.insert(_tableName, task!.toJson());}
   catch(e){
      print('we are here');
      return 900000;
   }

 }
 static Future<int> delete(Task? task) async {
   print('; delete ');
   return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task!.id]);
 }
 static Future<List<Map<String,dynamic>>> query() async {
   print('; delete ');
   return await _db!.query(_tableName);
 }
 static Future<int> update(int id ) async {
   print('; update ');
   return await _db!.rawUpdate('''
   UPDATE task 
   SET isCompleted =?
   WHERE id =?
   ''',[1,id]);
  }
}


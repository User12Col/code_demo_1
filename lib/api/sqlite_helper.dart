import 'package:code_demo_2/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';

class SqliteHelper {
  Future<Database> openData() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'note_database.db');

    Database database = await openDatabase(
      dbPath,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, date TEXT, content TEXT)',
        );
      },
    );

    return database;
  }

  Future<void> insertNote(Note note) async {
    final db = await openData();
    await db.insert('note', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Note>> notes() async {
    final db = await openData();

    final List<Map<String, dynamic>> maps = await db.query('note');

    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          title: maps[i]['title'],
          date: maps[i]['date'],
          content: maps[i]['content']);
    });
  }

  Future<void> updateNote(Note note) async {
    final db = await openData();
    await db.update('note', note.toMap(), where: 'id=?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id) async{
    final db = await openData();
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}

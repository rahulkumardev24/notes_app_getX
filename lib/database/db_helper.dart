

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/notes_model.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstances = DbHelper._();
  Database? mainDb;

  static String table_notes = 'notes';
  static String Notes_Col_NID = 'nid';
  static String Notes_Col_Title = 'title';
  static String Notes_Col_Desc = 'desc';

  Future<Database> getDb() async {
    mainDb ??= await openDb();
    return mainDb!;
  }

  Future<Database> openDb() async {
    Directory mainDirectory = await getApplicationDocumentsDirectory();
    String rootPath = join(mainDirectory.path, 'user.db');
    return openDatabase(rootPath, version: 1, onCreate: (db, version) {
      db.rawQuery('''create table $table_notes (
      $Notes_Col_NID integer primary key autoincrement,
      $Notes_Col_Title text,
      $Notes_Col_Desc text)''');
    });
  }

  Future<bool> addNoteDb({required NoteModel newNote}) async {
    var db = await getDb();
    int count = await db.insert(table_notes, newNote.toMap());
    return count > 0;
  }

  Future<bool> updateNoteDb(
      {required NoteModel newNote, required int nid}) async {
    var db = await getDb();
    int count = await db.update(table_notes, newNote.toMap(),
        where: '$Notes_Col_NID = ?', whereArgs: ['$nid']);
    return count > 0;
  }

  Future<List<NoteModel>> getNoteDb() async {
    var db = await getDb();
    var data = await db
        .query(table_notes);
    List<NoteModel> allNotes = [];
    for (Map<String, dynamic> eachNote in data) {
      allNotes.add(NoteModel.fromMap(eachNote));
    }
    return allNotes;
  }
}
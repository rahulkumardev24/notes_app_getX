import '../database/db_helper.dart';

class NoteModel {
  int? id;
  String title;
  String desc;

  NoteModel({required this.title, required this.desc, this.id});

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        title: map[DbHelper.Notes_Col_Title],
        desc: map[DbHelper.Notes_Col_Desc],
        id: map[DbHelper.Notes_Col_NID]);
  }

  Map<String,dynamic> toMap(){
    return {
      DbHelper.Notes_Col_Title: title,
      DbHelper.Notes_Col_Desc : desc
    };
  }
}
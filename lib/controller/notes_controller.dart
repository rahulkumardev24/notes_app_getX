

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../database/db_helper.dart';
import '../model/notes_model.dart';

class NoteController extends GetxController{

  //when change will apply it will observe and tell OBx
  RxList<NoteModel> allNote = <NoteModel>[].obs;

  DbHelper mainDb = Get.put(DbHelper.getInstances);
  void addInGetX({required NoteModel newNote})async{
    bool check = await mainDb.addNoteDb(newNote: newNote);
    if(check){
      allNote.value =await mainDb.getNoteDb();
    }
  }
  List<NoteModel> getNote(){
    return allNote;
  }

  void getInitialNote()async{
    allNote.value = await mainDb.getNoteDb();
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes_app_with_getx/screen/notes_home_screen.dart';

import '../controller/notes_controller.dart';
import '../model/notes_model.dart';

class AddNotesScreen extends StatelessWidget {
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  //for accessing all things of GetX we have to use it
  NoteController noteCon = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: titleC,
            ),
            TextField(
              controller: descC,
            ),
            ElevatedButton(
                onPressed: () {
                  noteCon.addInGetX(
                      newNote: NoteModel(
                          title: titleC.text.toString(),
                          desc: descC.text.toString()));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return NotesHomeScreen();
                      }));
                },
                child: Text("Add"))
          ],
        ),
      ),
    );
  }
}
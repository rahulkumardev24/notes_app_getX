

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/notes_controller.dart';
import 'add_notes_screen.dart';

class NotesHomeScreen extends StatefulWidget {
  @override
  State<NotesHomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NotesHomeScreen> {
  NoteController noteCon = Get.put(NoteController());

  @override
  void initState() {
    noteCon.getInitialNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        centerTitle: true,
      ),
      //Obx will update the UI whenever list will change in db
      //it will works as builder in Bloc
      body: Obx(() {
        return ListView.builder(
            itemCount: noteCon.allNote.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(noteCon.allNote[index].title),
                subtitle: Text(noteCon.allNote[index].desc),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddNotesScreen();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
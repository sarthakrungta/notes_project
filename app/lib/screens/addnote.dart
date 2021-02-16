import 'package:app/api/api.dart';
import 'package:app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android_intent/android_intent.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final noteTitleController = TextEditingController();
  final noteDesController = TextEditingController();

  void _openGoogleCalendar() {
    final AndroidIntent intent = AndroidIntent(
        action: 'action_view', package: 'com.google.android.apps.calendar');
    intent.launch();
  }

  void onAdd() {
    final String textVal = noteTitleController.text;
    final String desVal = noteDesController.text;

    if (textVal.isNotEmpty && desVal.isNotEmpty) {
      final Note note = Note(title: textVal, description: desVal);
      Provider.of<NoteProvider>(context, listen: false).addnote(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: ListView(
        children: [
          Container(
              child: Column(
            children: [
              TextField(
                controller: noteTitleController,
              ),
              TextField(
                controller: noteDesController,
              ),
              RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                    onAdd();
                    Navigator.of(context).pop();
                  }),
              RaisedButton(
                  child: Text('ADD TO CALENDAR'),
                  onPressed: () {
                    onAdd();
                    _openGoogleCalendar();
                  }),
            ],
          ))
        ],
      ),
    );
  }
}

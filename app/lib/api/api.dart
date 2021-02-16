import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/note.dart';
import 'package:http/http.dart' as http;

class NoteProvider with ChangeNotifier {
  NoteProvider() {
    this.fetchTasks();
  }

  List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes];
  }

  void addnote(Note note) async {
    final response = await http.post('http://10.0.2.2:8000/apis/v1/',
        headers: {"Content-Type": "application/json"}, body: json.encode(note));
    if (response.statusCode == 201) {
      note.id = json.decode(response.body)['id'];
      _notes.add(note);
      notifyListeners();
    }
  }

  void deletenote(Note note) async {
    final response =
        await http.delete('http://10.0.2.2:8000/apis/v1/${note.id}/');
    if (response.statusCode == 204) {
      _notes.remove(note);
      notifyListeners();
    }
  }

  fetchTasks() async {
    final url = 'http://10.0.2.2:8000/apis/v1/?format=json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _notes = data.map<Note>((json) => Note.fromJson(json)).toList();
      notifyListeners();
    }
  }
}

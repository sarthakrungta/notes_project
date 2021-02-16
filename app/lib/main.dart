import 'package:app/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/addnote.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteP = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Notes'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: noteP.notes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    noteP.deletenote(noteP.notes[index]);
                  }),
              title: Text(
                noteP.notes[index].title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                noteP.notes[index].description,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => AddNoteScreen()));
          }),
    );
  }
}

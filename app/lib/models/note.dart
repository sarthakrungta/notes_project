class Note {
  int id;
  final String title;
  final String description;

  Note({this.id, this.title, this.description});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        id: json['id'], title: json['title'], description: json['description']);
  }
  dynamic toJson() => {'id': id, 'title': title, 'description': description};
}

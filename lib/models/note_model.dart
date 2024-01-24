import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? id;
  String title;
  String content;
  DateTime modifiedTime;
  bool completed;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
    required this.completed,
  });

  factory NoteModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return NoteModel(
      id: snapshot.id,
      title: data['title'],
      content: data['content'],
      modifiedTime: (data['modifiedTime'] as Timestamp).toDate(),
      completed: data['completed'],
    );
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      modifiedTime: (map['modifiedTime'] as Timestamp).toDate(),
      completed: map['completed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'modifiedTime': Timestamp.fromDate(modifiedTime),
      'completed': completed,
    };
  }
}

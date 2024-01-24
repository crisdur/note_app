import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? noteId;
  String? userId;
  String title;
  String content;
  DateTime modifiedTime;
  bool? completed;
  Map<String, dynamic>? translatedContent;

  NoteModel({
    this.noteId,
    this.userId,
    required this.title,
    required this.content,
    required this.modifiedTime,
    this.completed,
    this.translatedContent,
  });

  factory NoteModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return NoteModel(
      noteId: snapshot.id,
      userId: data['userId'],
      title: data['title'],
      content: data['content'],
      modifiedTime: data['modifiedTime'] != null
          ? (data['modifiedTime'] as Timestamp).toDate()
          : DateTime.now(),
      completed: data['completed'],
      translatedContent: data['translatedContent'],
    );
  }

  factory NoteModel.fromMap(Map<String, dynamic> map, String documentId) {
    return NoteModel(
      noteId: documentId,
      userId: map['userId'],
      title: map['title'],
      content: map['content'],
      modifiedTime: map['modifiedTime'] != null
          ? (map['modifiedTime'] as Timestamp).toDate()
          : DateTime.now(),
      completed: map['completed'],
      translatedContent: map['translatedContent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'userId': userId,
      'title': title,
      'content': content,
      'modifiedTime': modifiedTime,
      'completed': completed,
      'translatedContent': translatedContent,
    };
  }
}

class NoteModel {
  int id;
  String title;
  String content;
  DateTime modifiedTime;
  bool completed;

  NoteModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.modifiedTime,
      required this.completed});
}

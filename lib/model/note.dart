class Note{
  int? id;
  String title;
  String date;
  String content;

  Note({this.id, required this.title,required this.date,required this.content});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'content': content
    };
  }
}
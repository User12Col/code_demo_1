class Note{
  int id;
  String title;
  String date;
  String content;

  Note({required this.id, required this.title,required this.date,required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'content': content
    };
  }
}
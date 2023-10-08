import 'package:code_demo_2/api/sqlite_helper.dart';
import 'package:code_demo_2/model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditNoteScreen extends StatefulWidget {
  int id;
  String title;
  String content;

  EditNoteScreen({Key? key,required this.id, required this.title, required this.content})
      : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void insertNote(Note note) async{
    await SqliteHelper().insertNote(note);
  }

  void updateNote(Note note) async{
    await SqliteHelper().updateNote(note);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _titleController.text = widget.title;
      _contentController.text = widget.content;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Notes'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: (){
              if(widget.id == -1){
                Note note = Note(id: 0, title: _titleController.text, date: DateFormat.yMMMd().format(DateTime.now()), content: _contentController.text);
                insertNote(note);
                Navigator.pop(context);
              } else{
                Note note = Note(id: widget.id, title: _titleController.text, date: DateFormat.yMMMd().format(DateTime.now()), content: _contentController.text);
                updateNote(note);
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                'Title',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                style: TextStyle(color: Colors.black),
                controller: _titleController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                'Content',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none
                ),
                style: TextStyle(color: Colors.black),
                controller: _contentController,
                maxLines: 8,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

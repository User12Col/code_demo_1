import 'package:code_demo_2/api/sqlite_helper.dart';
import 'package:code_demo_2/model/note.dart';
import 'package:code_demo_2/screen/edit_note_screen.dart';
import 'package:flutter/material.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: SqliteHelper().notes(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No notes available.'));
        } else{
          List<Note> notes = snapshot.data!;
          return ListView.separated(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async{
                  String rs = await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>EditNoteScreen(
                      id: notes[index].id!,title: notes[index].title, content: notes[index].content)));
                  if(rs == 'true'){
                    setState(() {
                      notes = snapshot.data!;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: Colors.white
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: index == 0
                      ? const EdgeInsets.only(top: 10, left: 10, right: 10)
                      : const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notes[index].title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        notes[index].date,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        notes[index].content,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          );
        }
      },
    );
  }
}

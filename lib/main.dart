import 'package:code_demo_2/screen/edit_note_screen.dart';
import 'package:code_demo_2/screen/note_list_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    title: 'Multi Notes',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Notes'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.create_rounded),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          EditNoteScreen(id: -1, title: '', content: '')));
            },
          )
        ],
      ),
      body: NoteListScreen(),
    );
  }
}

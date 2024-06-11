import 'package:flutter/material.dart';
import 'package:notes/widgets/notescontainer.dart';

class NotesPage extends StatelessWidget {
  final List<String> notes = [
    'Meeting with John',
    'Buy groceries',
    'Complete the project report',
    'Call mom',
    'Schedule dentist appointment',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NotesContainer(
              note: notes[index],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

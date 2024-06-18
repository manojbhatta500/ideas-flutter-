import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/bloc/notes/notes_bloc.dart';
import 'package:notes/screens/add_note.dart';
import 'package:notes/widgets/notescontainer.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(GetNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is FetchNotesSuccess) {
              int leng = state.data.notes!.length;
              if (leng < 1) {
                return Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Lottie.asset(
                        'assets/test.json',
                      ),
                    ),
                    Center(
                      child: Text(
                        'No Notes found.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: leng,
                  itemBuilder: (context, index) {
                    return NotesContainer(
                      note: state.data.notes![index].title!,
                      individaualData: state.data.notes![index],
                    );
                  },
                );
              }
            } else if (state is NotesProcessing) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchNotesFailed) {
              return Center(
                child: Text(
                    'Sorry, we are working on it. Failed seems to be down'),
              );
            } else {
              return Center(
                child: Text(
                    'Sorry, we are working on it. Else method seems to be down'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

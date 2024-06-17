import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/notes/notes_bloc.dart';
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
                return Center(
                  child: Text('No Notes found please add some notes'),
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
                child:
                    Text('sorry we are working on it. failed seems to be down'),
              );
            } else {
              return Center(
                child: Text(
                    'sorry we are working on it. else method seems to be down'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddNoteSheet(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddNoteSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddNoteSheet();
      },
    );
  }
}

class AddNoteSheet extends StatefulWidget {
  @override
  _AddNoteSheetState createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends State<AddNoteSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16.0,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocListener<NotesBloc, NotesState>(
                  listener: (context, state) {
                    if (state is CreateNotesSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Successfully created')));
                      Navigator.pop(context);
                    } else if (state is CreateNotesFailed) {
                      log('this is else if  create notes failed method of create notes bloc');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Something went wrong try again')));
                    } else if (state is NotesProcessing) {
                      log('sorry this  will probabbly always run');
                      //  i am managing all the states inside one bloc because i am lazy and
                      //  inside the production don't do it rn i just don't wanna use different states for diffrent event
                    } else {
                      log('this is else method of create notes bloc');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Something went wrong try again')));
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<NotesBloc>(context).add(CreateNote(
                          title: _titleController.text,
                          desc: _descriptionController.text));
                    },
                    child: Text('Add Note'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

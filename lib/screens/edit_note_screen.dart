import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/notes/notes_bloc.dart';
import 'package:notes/models/all_notes_model.dart';
import 'package:notes/screens/homepage.dart';

class EditNoteScreen extends StatefulWidget {
  final Notes note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title ?? '';
    _descriptionController.text = widget.note.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
              BlocListener<NotesBloc, NotesState>(
                listener: (context, state) {
                  if (state is EditNotesSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Successfully updated.')));
                    log('step 1');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Homepage())); // Close the screen
                  } else if (state is EditNotesFailed) {
                    log('step 2');

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Something went wrong, try again')));
                  } else if (state is NotesProcessing) {
                    log('step 3');

                    log('Processing...');
                  } else {
                    log('step 4');

                    log('Unknown state');
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<NotesBloc>(context).add(EditNote(
                          id: widget.note.sId!,
                          title: _titleController.text,
                          desc: _descriptionController.text));
                    }
                  },
                  child: Text('Update Note'),
                ),
              ),
            ],
          ),
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

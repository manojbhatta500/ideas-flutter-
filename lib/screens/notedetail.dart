import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/notes/notes_bloc.dart';
import 'dart:math';

import 'package:notes/models/all_notes_model.dart';
import 'package:notes/screens/edit_note_screen.dart';
import 'package:notes/screens/homepage.dart';

class NoteDetail extends StatefulWidget {
  final Notes notes;
  NoteDetail({super.key, required this.notes});

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  int customSize = 18;
  late Color randomColor;

  @override
  void initState() {
    super.initState();
    final random = Random();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFC9C2C),
        appBar: AppBar(
          backgroundColor: Color(0XFFFC9C2C),
          actions: [
            IconButton(
                onPressed: () {
                  if (customSize > 12) {
                    setState(() {
                      customSize = customSize - 1;
                    });
                  }
                },
                icon: Icon(Icons.remove)),
            Text(
              customSize.toString(),
              style: TextStyle(fontSize: 23),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    customSize = customSize + 1;
                  });
                },
                icon: Icon(Icons.add)),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.notes.title!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        Text(
                          widget.notes.description!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: customSize.toDouble()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditNoteScreen(note: widget.notes)));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  BlocListener<NotesBloc, NotesState>(
                    listener: (context, state) {
                      if (state is DeleteNoteSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('successfully deleted.')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                      } else if (state is DeleteNoteFailed) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('try again')));
                      } else if (state is NotesProcessing) {
                        print('this is just processing on');
                      } else {
                        print('this is just else');
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        showDeleteConfirmationDialog(
                            context, widget.notes.sId!);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showDeleteConfirmationDialog(BuildContext context, String noteId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Note'),
        content: Text('Do you really want to delete this note?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<NotesBloc>(context).add(DeleteNote(id: noteId));
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}

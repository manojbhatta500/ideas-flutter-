import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/models/all_notes_model.dart';
import 'dart:math';

import 'package:notes/screens/notedetail.dart';

class NotesContainer extends StatelessWidget {
  final String note;
  final Notes individaualData;

  NotesContainer(
      {required this.note, required this.individaualData, super.key});

  final List<String> lottieAssets = [
    'assets/notes1.json',
    'assets/notes3.json',
    'assets/notes2.json',
  ];

  // 'assets/notes3.json'
  final List<Color> containerColors = [
    Colors.blueAccent,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.purpleAccent,
    Colors.lightGreen,
    Colors.indigoAccent,
    Colors.cyan
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final random = Random();
    final randomLottie = lottieAssets[random.nextInt(lottieAssets.length)];
    final randomColor = containerColors[random.nextInt(containerColors.length)];

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDetail(
                      notes: individaualData,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 0.15 * height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: randomColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              Lottie.asset(
                randomLottie,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      note,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

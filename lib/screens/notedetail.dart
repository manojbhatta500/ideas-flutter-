import 'package:flutter/material.dart';
import 'dart:math';

class NoteDetail extends StatefulWidget {
  NoteDetail({super.key});

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
                            'it dosent matter',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        Text(
                          'i will become a great fullstack flutter and node js developer one day just see ',
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

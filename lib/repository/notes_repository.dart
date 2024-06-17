import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:notes/models/all_notes_model.dart';
import 'package:notes/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:notes/utils/token.dart';

class NotesRepository {
  Future<int> createNote({required String title, required String desc}) async {
    final url = Uri.parse(Apis.createNote);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Token.token}',
      },
      body: json.encode({
        'title': title,
        'description': desc,
      }),
    );

    if (response.statusCode == 200) {
      log('create notes was success');
      log(response.body);
      return 1;
    } else {
      log('create notes failed request');
      log(response.body);
      return 0;
    }
  }

  Future<Either<AllNotesModel, int>> getNotes() async {
    final url = Uri.parse(Apis.fetchNotes);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Token.token}',
      },
    );

    if (response.statusCode == 200) {
      log('create notes was success');
      log(response.body);

      final alldata = AllNotesModel.fromJson(jsonDecode(response.body));

      return Left(alldata);
    } else {
      log('create notes failed request');
      log(response.body);
      return Right(1);
    }
  }

  void editNote() async {}
  void deleteNote() async {}
}

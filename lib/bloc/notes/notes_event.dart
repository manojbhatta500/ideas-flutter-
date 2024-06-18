part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class CreateNote extends NotesEvent {
  final String title, desc;
  CreateNote({required this.title, required this.desc});
}

final class EditNote extends NotesEvent {
  final String id;
  final String title;
  final String desc;
  EditNote({required this.id, required this.title, required this.desc});
}

final class GetNotes extends NotesEvent {}

final class DeleteNote extends NotesEvent {
  final String id;
  DeleteNote({required this.id});
}

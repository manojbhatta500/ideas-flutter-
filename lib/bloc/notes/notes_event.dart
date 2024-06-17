part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class CreateNote extends NotesEvent {
  final String title, desc;
  CreateNote({required this.title, required this.desc});
}

final class EditNote extends NotesEvent {}

final class GetNotes extends NotesEvent {}

final class DeleteNote extends NotesEvent {}

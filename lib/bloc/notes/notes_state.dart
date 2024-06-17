part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesProcessing extends NotesState {}

final class CreateNotesSuccess extends NotesState {}

final class CreateNotesFailed extends NotesState {}

final class EditNotesFailed extends NotesState {}

final class EditNotesSuccess extends NotesState {}

final class DeleteNoteFailed extends NotesState {}

final class DeleteNoteSuccess extends NotesState {}

final class FetchNotesFailed extends NotesState {}

final class FetchNotesSuccess extends NotesState {
  AllNotesModel data;
  FetchNotesSuccess({required this.data});
}

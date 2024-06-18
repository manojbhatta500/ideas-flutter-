import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/models/all_notes_model.dart';
import 'package:notes/repository/notes_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<CreateNote>(_createNote);
    on<EditNote>(_editNote);
    on<GetNotes>(_getNotes);
    on<DeleteNote>(_deleteNote);
  }
  NotesRepository manager = NotesRepository();

  FutureOr<void> _createNote(CreateNote event, Emitter<NotesState> emit) async {
    emit(NotesProcessing());
    final repoResponse =
        await manager.createNote(title: event.title, desc: event.desc);
    if (repoResponse == 1) {
      emit(CreateNotesSuccess());
    } else {
      emit(CreateNotesFailed());
    }
  }

  FutureOr<void> _editNote(EditNote event, Emitter<NotesState> emit) async {
    emit(NotesProcessing());
    final repoResponse = await manager.editNote(
        id: event.id, title: event.title, desc: event.desc);
    if (repoResponse == 1) {
      emit(EditNotesSuccess());
    } else {
      emit(EditNotesFailed());
    }
  }

  FutureOr<void> _getNotes(GetNotes event, Emitter<NotesState> emit) async {
    emit(NotesProcessing());
    final repoResponse = await manager.getNotes();
    repoResponse.fold((l) {
      emit(FetchNotesSuccess(data: l));
    }, (r) {
      emit(FetchNotesFailed());
    });
  }

  FutureOr<void> _deleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    emit(NotesProcessing());
    final repoResponse = await manager.deleteNote(id: event.id);
    if (repoResponse == 1) {
      emit(DeleteNoteSuccess());
    } else {
      emit(DeleteNoteFailed());
    }
  }
}

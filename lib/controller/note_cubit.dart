import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note.dart';
import '../repository/note_repository_interface.dart';
import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final INoteRepository repository;

  NoteCubit(this.repository) : super(NoteInitial());

  void loadNotes() async {
    try {
      emit(NoteLoading());
      final notes = await repository.fetchNotes();
      emit(NoteLoaded(notes));
    } catch (_) {
      emit(NoteError('Failed to load notes'));
    }
  }

  void deleteNote(String id) async {
    try {
      emit(NoteLoading());
      await repository.deleteNote(id);
      final notes = await repository.fetchNotes();
      emit(NoteLoaded(notes));
    } catch (_) {
      emit(NoteError('Failed to delete note'));
    }
  }
}

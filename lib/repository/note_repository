abstract class INoteRepository {
  Future<List<Note>> fetchNotes();
  Future<void> deleteNote(String id);
}

class NoteRepository implements INoteRepository {
  final Dio dio;

  NoteRepository(this.dio);

  @override
  Future<List<Note>> fetchNotes() async {
    final response = await dio.get('/notes');
    return (response.data as List).map((e) => Note.fromJson(e)).toList();
  }

  @override
  Future<void> deleteNote(String id) async {
    await dio.delete('/notes/$id');
  }
}

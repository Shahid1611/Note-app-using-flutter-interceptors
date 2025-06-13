import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/note_cubit.dart';
import '../cubit/note_state.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  void _showDeleteConfirmation(BuildContext context, Note note, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) return Center(child: CircularProgressIndicator());
          if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_, i) {
                final note = state.notes[i];
                return ListTile(
                  title: Text(note.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _showDeleteConfirmation(context, note, () {
                      context.read<NoteCubit>().deleteNote(note.id);
                    }),
                  ),
                );
              },
            );
          }
          if (state is NoteError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}

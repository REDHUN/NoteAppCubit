import 'package:noteapp/feature/domain/entities/note_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class UpdateNoteUseCase {
  final FirebaseRepository repository;

  UpdateNoteUseCase({required this.repository});

  Future<void> call(NoteEntity note) async {
    return repository.updateNote(note);
  }
}

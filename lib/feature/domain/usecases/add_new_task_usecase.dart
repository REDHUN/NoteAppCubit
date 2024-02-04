import 'package:noteapp/feature/domain/entities/note_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class AddNewTaskUseCase {
  final FirebaseRepository repository;

  AddNewTaskUseCase({required this.repository});

  Future<void> call(NoteEntity note) async {
    return repository.addNewNote(note);
  }
}

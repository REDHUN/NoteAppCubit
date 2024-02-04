import 'package:noteapp/feature/domain/entities/note_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class GetNoteUseCase {
  final FirebaseRepository repository;

  GetNoteUseCase({required this.repository});

  Stream<List<NoteEntity>> call(String uid) {
    return repository.getNotes(uid);
  }
}

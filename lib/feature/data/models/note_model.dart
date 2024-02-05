import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/feature/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel(
      {required super.noteId,
      required super.note,
      required super.time,
      required super.uid});

  factory NoteModel.fromSnapshot(DocumentSnapshot documentSnapshot) =>
      NoteModel(
          noteId: documentSnapshot.get('noteId'),
          note: documentSnapshot.get('note'),
          time: documentSnapshot.get('time'),
          uid: documentSnapshot.get('uid'));

  Map<String, dynamic> toDocument() {
    return {
      "noteId": noteId,
      'note': note,
      'time': time,
      'uid': uid,
    };
  }
}

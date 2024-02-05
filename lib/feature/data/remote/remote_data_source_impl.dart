import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/feature/data/models/note_model.dart';
import 'package:noteapp/feature/data/models/user_model.dart';
import 'package:noteapp/feature/data/remote/remote_data_source.dart';
import 'package:noteapp/feature/domain/entities/note_entity.dart';
import 'package:noteapp/feature/domain/entities/user_entity.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  RemoteDataSourceImpl({required this.auth, required this.firestore});
  @override
  Future<void> addNewNote(NoteEntity noteEntity) async {
    final noteCollectionRef =
        firestore.collection('users').doc(noteEntity.uid).collection('notes');
    final noteId = noteCollectionRef.doc().id;
    noteCollectionRef.doc(noteId).get().then((note) {
      final newNote = NoteModel(
              noteId: noteEntity.noteId,
              note: noteEntity.note,
              time: noteEntity.time,
              uid: noteEntity.uid)
          .toDocument();
      if (!note.exists) {
        noteCollectionRef.doc(noteId).set(newNote);
      }
      return;
    });
  }

  @override
  Future<void> deleteNote(NoteEntity noteEntity) async {
    final noteCollectionRef =
        firestore.collection('users').doc(noteEntity.uid).collection('notes');
    noteCollectionRef.doc(noteEntity.noteId).get().then((note) {
      if (note.exists) {
        noteCollectionRef.doc(noteEntity.noteId).delete();
      }
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final uid = await getCurrentUid();
    final userCollectionRef = firestore.collection('users');
    userCollectionRef.doc(user.uid).get().then((value) async {
      final newUser = UserModel(
              name: user.name, email: user.email, uid: uid, status: user.status)
          .toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUid() async {
    return auth.currentUser!.uid;
  }

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    final noteCollectionRef =
        firestore.collection('users').doc(uid).collection('notes');
    return noteCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs.map((docSnap) {
        return NoteModel.fromSnapshot(docSnap);
      }).toList();
    });
  }

  @override
  Future<bool> isSignIn() async {
    return auth.currentUser?.uid != null;
  }

  @override
  Future<void> signIn(UserEntity user) async {
    auth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Future<void> signOut(UserEntity user) async {
    return auth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    auth.createUserWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    Map<String, dynamic> noteMap = Map();
    final noteCollectionRef =
        firestore.collection('users').doc(note.uid).collection('notes');
    if (note.note != null) noteMap['note'] = note.note;
    if (note.time != null) noteMap['time'] = note.time;
    noteCollectionRef.doc(note.noteId).update(noteMap);
  }
}

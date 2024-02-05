import 'package:noteapp/feature/data/remote/remote_data_source.dart';
import 'package:noteapp/feature/domain/entities/note_entity.dart';
import 'package:noteapp/feature/domain/entities/user_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final RemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> addNewNote(NoteEntity note) async {
    return remoteDataSource.addNewNote(note);
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    return remoteDataSource.deleteNote(note);
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    return remoteDataSource.getCreateCurrentUser(user);
  }

  @override
  Future<String> getCurrentUid() async {
    return remoteDataSource.getCurrentUid();
  }

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    return remoteDataSource.getNotes(uid);
  }

  @override
  Future<bool> isSignIn() async {
    return remoteDataSource.isSignIn();
  }

  @override
  Future<void> signIn(UserEntity user) async {
    return remoteDataSource.signIn(user);
  }

  @override
  Future<void> signOut(UserEntity user) async {
    return remoteDataSource.signOut(user);
  }

  @override
  Future<void> signUp(UserEntity user) async {
    return remoteDataSource.signUp(user);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    return remoteDataSource.updateNote(note);
  }
}

import 'package:noteapp/feature/domain/entities/user_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class SignOutUseCase {
  final FirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signOut(user);
  }
}

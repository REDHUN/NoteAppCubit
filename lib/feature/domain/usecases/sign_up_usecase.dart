import 'package:noteapp/feature/domain/entities/user_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signIn(user);
  }
}

import 'package:noteapp/feature/domain/entities/user_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signIn(user);
  }
}

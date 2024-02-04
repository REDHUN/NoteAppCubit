import 'package:noteapp/feature/domain/entities/user_entity.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}

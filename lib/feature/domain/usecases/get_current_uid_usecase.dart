import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUid();
  }
}

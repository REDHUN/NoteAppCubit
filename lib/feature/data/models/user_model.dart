import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.name,
      required super.email,
      required super.uid,
      required super.status,
      super.password});

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot.get('name'),
      email: documentSnapshot.get('email'),
      uid: documentSnapshot.get('uid'),
      status: documentSnapshot.get('status'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {'status': status, 'name': name, 'uid': uid, 'email': email};
  }
}

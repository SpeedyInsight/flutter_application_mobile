import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  UserModel({required this.username, required this.email, required this.password});

  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @override
  String toString() {
    return 'UserModel{username: $username, email: $email, password: $password}';
  }
}

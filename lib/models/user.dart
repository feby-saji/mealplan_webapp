import 'package:hive_flutter/adapters.dart';
part 'user.g.dart';

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String familyId;
  @HiveField(3)
  final String uid;

  UserModel({
    required this.email,
    required this.familyId,
    required this.uid,
    required this.name,
  });
}

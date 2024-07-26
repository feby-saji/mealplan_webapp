import 'package:hive_flutter/adapters.dart';
part 'admin.g.dart';

@HiveType(typeId: 1)
class AdminModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final int usersCount;
  @HiveField(3)
  final int familysCount;
  @HiveField(4)
  bool loggedIn;

  AdminModel({
    required this.email,
    required this.loggedIn,
    required this.usersCount,
    required this.familysCount,
    required this.name,
  });
}

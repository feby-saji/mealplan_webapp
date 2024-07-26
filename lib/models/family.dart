import 'package:hive_flutter/adapters.dart';
part 'family.g.dart';

@HiveType(typeId: 2)
class FamilyModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String creator;
  @HiveField(2)
  final List<String> members;
  @HiveField(3)
  final String createdOn;

  FamilyModel({
    required this.id,
    required this.createdOn,
    required this.creator,
    required this.members,
  });
}
  
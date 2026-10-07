import 'user_role.dart';

class Profile {
  Profile({required this.id, required this.name, required this.role});
  final String id;
  final String name;
  final UserRole role;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'role': role.name};

  factory Profile.fromJson(Map<String, dynamic> j) => Profile(
        id: j['id'] as String,
        name: j['name'] as String,
        role: UserRole.values.byName(j['role'] as String),
      );
}

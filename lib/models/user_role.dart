enum UserRole { child, woman, man }

extension UserRoleX on UserRole {
  String get label => switch (this) {
        UserRole.child => 'بچے',
        UserRole.woman => 'خواتین',
        UserRole.man => 'مرد',
      };
}

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String country;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  UserProfile toEntity() {
    return UserProfile(
      id: id,
      name: name,
      email: email,
      phone: phone,
      country: country,
    );
  }

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      country: entity.country,
    );
  }
}

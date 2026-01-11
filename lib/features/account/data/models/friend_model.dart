import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/friend.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class FriendModel {
  final String id;
  final String name;
  final String avatarUrl;
  final int level;
  final bool isOnline;

  const FriendModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.level,
    required this.isOnline,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendModelToJson(this);

  Friend toEntity() {
    return Friend(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      level: level,
      isOnline: isOnline,
    );
  }

  factory FriendModel.fromEntity(Friend entity) {
    return FriendModel(
      id: entity.id,
      name: entity.name,
      avatarUrl: entity.avatarUrl,
      level: entity.level,
      isOnline: entity.isOnline,
    );
  }
}

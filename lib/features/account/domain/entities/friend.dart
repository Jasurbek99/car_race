import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final int level;
  final bool isOnline;

  const Friend({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.level,
    required this.isOnline,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, level, isOnline];
}

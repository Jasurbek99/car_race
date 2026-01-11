import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String country;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, email, phone, country];

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? country,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
    );
  }
}

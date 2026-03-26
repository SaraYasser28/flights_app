import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String? profilePicture;
  final String? membershipTier;
  final List<String> favoriteFlightIds;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.profilePicture,
    this.membershipTier,
    this.favoriteFlightIds = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePicture: json['profilePicture'] as String?,
      membershipTier: json['membershipTier'] as String?,
      favoriteFlightIds:
          (json['favoriteFlightIds'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'membershipTier': membershipTier,
      'favoriteFlightIds': favoriteFlightIds,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? profilePicture,
    String? membershipTier,
    List<String>? favoriteFlightIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      membershipTier: membershipTier ?? this.membershipTier,
      favoriteFlightIds: favoriteFlightIds ?? this.favoriteFlightIds,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    password,
    profilePicture,
    membershipTier,
    favoriteFlightIds,
  ];
}

import 'package:equatable/equatable.dart';

import 'user.dart';

class Data extends Equatable {
  final User? user;
  final String? token;
  final List<String>? permissions;

  const Data({this.user, this.token, this.permissions});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String?,
        permissions: List<String>.from(json['permissions'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'token': token,
        'permissions': permissions,
      };

  @override
  List<Object?> get props => [user, token, permissions];
}

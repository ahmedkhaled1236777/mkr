import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? id;
  final String? name;
  final dynamic img;
  final String? email;
  final dynamic phone;
  final dynamic jobTitle;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;
  final List<String>? permissions;

  const Data({
    this.id,
    this.name,
    this.img,
    this.email,
    this.phone,
    this.jobTitle,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.permissions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        img: json['img'] as dynamic,
        email: json['email'] as String?,
        phone: json['phone'] as dynamic,
        jobTitle: json['job_title'] as dynamic,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        token: json['token'] as String?,
        permissions: List<String>.from(json['permissions'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'img': img,
        'email': email,
        'phone': phone,
        'job_title': jobTitle,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'token': token,
        'permissions': permissions,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      img,
      email,
      phone,
      jobTitle,
      emailVerifiedAt,
      createdAt,
      updatedAt,
      token,
      permissions,
    ];
  }
}

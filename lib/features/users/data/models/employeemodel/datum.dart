import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final int? isActive;
  final int? roleId;
  final String? name;
  final dynamic img;
  final String? email;
  final String? phone;
  final String? jobTitle;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Datum({
    this.id,
    this.isActive,
    this.roleId,
    this.name,
    this.img,
    this.email,
    this.phone,
    this.jobTitle,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        isActive: json['is_active'] as int?,
        roleId: json['role_id'] as int?,
        name: json['name'] as String?,
        img: json['img'] as dynamic,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        jobTitle: json['job_title'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_active': isActive,
        'role_id': roleId,
        'name': name,
        'img': img,
        'email': email,
        'phone': phone,
        'job_title': jobTitle,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      isActive,
      roleId,
      name,
      img,
      email,
      phone,
      jobTitle,
      emailVerifiedAt,
      createdAt,
      updatedAt,
    ];
  }
}

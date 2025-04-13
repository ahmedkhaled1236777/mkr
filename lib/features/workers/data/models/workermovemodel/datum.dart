import 'package:equatable/equatable.dart';

class datamoves extends Equatable {
  final int? id;
  final int? status;
  final String? date;
  final int? employerId;
  final num? numberOfHours;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? type;

  const datamoves({
    this.id,
    this.status,
    this.date,
    this.employerId,
    this.numberOfHours,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  factory datamoves.fromJson(Map<String, dynamic> json) => datamoves(
        id: json['id'] as int?,
        status: json['status'] as int?,
        date: json['date'] as String?,
        employerId: json['employer_id'] as int?,
        numberOfHours: json['number_of_hours'] as num?,
        notes: json['notes'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'date': date,
        'employer_id': employerId,
        'number_of_hours': numberOfHours,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'type': type,
      };

  @override
  List<Object?> get props {
    return [
      id,
      status,
      date,
      employerId,
      numberOfHours,
      notes,
      createdAt,
      updatedAt,
      type,
    ];
  }
}

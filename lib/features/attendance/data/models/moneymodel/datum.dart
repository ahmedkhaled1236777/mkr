import 'package:equatable/equatable.dart';

class moneymoves extends Equatable {
  final int? id;
  final int? employerId;
  final num? amount;
  final String? type;
  final String? notes;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const moneymoves({
    this.id,
    this.employerId,
    this.amount,
    this.type,
    this.notes,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory moneymoves.fromJson(Map<String, dynamic> json) => moneymoves(
        id: json['id'] as int?,
        employerId: json['employer_id'] as int?,
        amount: json['amount'],
        type: json['type'] as String?,
        notes: json['notes'] as String?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'employer_id': employerId,
        'amount': amount,
        'type': type,
        'notes': notes,
        'date': date?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      employerId,
      amount,
      type,
      notes,
      date,
      createdAt,
      updatedAt,
    ];
  }
}

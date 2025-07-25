import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? process;
  final String? pay;
  final String? destination;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? totalPaid;
  final num? totalProcess;

  const Datum({
    this.id,
    this.name,
    this.phone,
    this.process,
    this.pay,
    this.destination,
    this.createdAt,
    this.updatedAt,
    this.totalPaid,
    this.totalProcess,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        process: json['process'],
        pay: json['pay'],
        destination: json['destination'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        totalPaid: (json['total_paid']),
        totalProcess: (json['total_process']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'process': process,
        'pay': pay,
        'destination': destination,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'total_paid': totalPaid,
        'total_process': totalProcess,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      phone,
      process,
      pay,
      destination,
      createdAt,
      updatedAt,
      totalPaid,
      totalProcess,
    ];
  }
}

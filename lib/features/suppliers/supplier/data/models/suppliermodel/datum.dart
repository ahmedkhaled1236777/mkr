import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final num? pay;
  final num? process;
  final String? destination;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? totalPaid;
  final num? totalProcess;

  const Datum({
    this.id,
    this.name,
    this.phone,
    this.pay,
    this.process,
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
        pay: (json['pay'] as num?),
        process: json['process'] as num?,
        destination: json['destination'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        totalPaid: (json['total_paid'] as num?),
        totalProcess: json['total_process'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'pay': pay,
        'process': process,
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
      pay,
      process,
      destination,
      createdAt,
      updatedAt,
      totalPaid,
      totalProcess,
    ];
  }
}

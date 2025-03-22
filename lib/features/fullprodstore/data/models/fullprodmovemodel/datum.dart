import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final String? discountPercentage;
  final int? warehouseId;
  final bool? status;
  final String? date;
  final int? qty;
  final String? price;
  final String? nameOfClient;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const datummoves({
    this.id,
    this.discountPercentage,
    this.warehouseId,
    this.status,
    this.date,
    this.qty,
    this.price,
    this.nameOfClient,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory datummoves.fromJson(Map<String, dynamic> json) => datummoves(
        id: json['id'] as int?,
        discountPercentage: json['discount_percentage'] as String?,
        warehouseId: json['warehouse_id'] as int?,
        status: json['status'] as bool?,
        date: json['date'] as String?,
        qty: json['qty'] as int?,
        price: json['price'] as String?,
        nameOfClient: json['name_of_client'] as String?,
        notes: json['notes'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'discount_percentage': discountPercentage,
        'warehouse_id': warehouseId,
        'status': status,
        'date': date,
        'qty': qty,
        'price': price,
        'name_of_client': nameOfClient,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      discountPercentage,
      warehouseId,
      status,
      date,
      qty,
      price,
      nameOfClient,
      notes,
      createdAt,
      updatedAt,
    ];
  }
}

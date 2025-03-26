import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final int? type;
  final dynamic discountPercentage;
  final int? warehouseId;
  final bool? status;
  final String? date;
  final num? qty;
  final String? price;
  final String? nameOfClient;
  final dynamic notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const datummoves({
    this.id,
    this.type,
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
        type: json['type'] as int?,
        discountPercentage: json['discount_percentage'] as dynamic,
        warehouseId: json['warehouse_id'] as int?,
        status: json['status'] as bool?,
        date: json['date'] as String?,
        qty: json['qty'] as num?,
        price: json['price'] as String?,
        nameOfClient: json['name_of_client'] as String?,
        notes: json['notes'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
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
      type,
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

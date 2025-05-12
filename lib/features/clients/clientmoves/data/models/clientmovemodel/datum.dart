import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final int? type;
  final int? status;
  final String? discountPercentage;
  final int? clientId;
  final String? date;
  final int? warehouseId;
  final num? qty;
  final String? price;
  final dynamic notes;
  final String? packagingType;
  final num? unitsPerPackaging;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? warehouseName;

  const datummoves({
    this.id,
    this.type,
    this.status,
    this.discountPercentage,
    this.clientId,
    this.date,
    this.warehouseId,
    this.qty,
    this.price,
    this.notes,
    this.packagingType,
    this.unitsPerPackaging,
    this.createdAt,
    this.updatedAt,
    this.warehouseName,
  });

  factory datummoves.fromJson(Map<String, dynamic> json) => datummoves(
        id: json['id'] as int?,
        type: json['type'] as int?,
        status: json['status'] as int?,
        discountPercentage: json['discount_percentage'] as String?,
        clientId: json['client_id'] as int?,
        date: json['date'] as String?,
        warehouseId: json['warehouse_id'] as int?,
        qty: json['qty'] as num?,
        price: json['price'] as String?,
        notes: json['notes'] as dynamic,
        packagingType: json['packaging_type'] as String?,
        unitsPerPackaging: json['units_per_packaging'] as num?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        warehouseName: json['warehouse_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'status': status,
        'discount_percentage': discountPercentage,
        'client_id': clientId,
        'date': date,
        'warehouse_id': warehouseId,
        'qty': qty,
        'price': price,
        'notes': notes,
        'packaging_type': packagingType,
        'units_per_packaging': unitsPerPackaging,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'warehouse_name': warehouseName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      type,
      status,
      discountPercentage,
      clientId,
      date,
      warehouseId,
      qty,
      price,
      notes,
      packagingType,
      unitsPerPackaging,
      createdAt,
      updatedAt,
      warehouseName,
    ];
  }
}

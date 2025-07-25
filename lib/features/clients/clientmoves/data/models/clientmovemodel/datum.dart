import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final String? status;
  final dynamic discountPercentage;
  final String? clientId;
  final String? date;
  final String? warehouseId;
  final String? qty;
  final String? price;
  final String? notes;
  final dynamic packagingType;
  final String? unitsPerPackaging;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? warehouseName;

  const datummoves({
    this.id,
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
        status: json['status'] as String?,
        discountPercentage: json['discount_percentage'] as dynamic,
        clientId: json['client_id'] as String?,
        date: json['date'] as String?,
        warehouseId: json['warehouse_id'] as String?,
        qty: json['qty'] as String?,
        price: json['price'] as String?,
        notes: json['notes'] as String?,
        packagingType: json['packaging_type'] as dynamic,
        unitsPerPackaging: json['units_per_packaging'] as String?,
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

import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final int? type;
  final int? stockId;
  final dynamic discountPercentage;
  final bool? status;
  final String? date;
  final num? qty;
  final String? price;
  final String? nameOfSupplier;
  final dynamic notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const datummoves({
    this.id,
    this.type,
    this.stockId,
    this.discountPercentage,
    this.status,
    this.date,
    this.qty,
    this.price,
    this.nameOfSupplier,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory datummoves.fromJson(Map<String, dynamic> json) => datummoves(
        id: json['id'] as int?,
        type: json['type'] as int?,
        stockId: json['stock_id'] as int?,
        discountPercentage: json['discount_percentage'] as dynamic,
        status: json['status'] as bool?,
        date: json['date'] as String?,
        qty: json['qty'] as num?,
        price: json['price'] as String?,
        nameOfSupplier: json['name_of_supplier'] as String?,
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
        'stock_id': stockId,
        'discount_percentage': discountPercentage,
        'status': status,
        'date': date,
        'qty': qty,
        'price': price,
        'name_of_supplier': nameOfSupplier,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      type,
      stockId,
      discountPercentage,
      status,
      date,
      qty,
      price,
      nameOfSupplier,
      notes,
      createdAt,
      updatedAt,
    ];
  }
}

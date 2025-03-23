import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final int? status;
  final dynamic notes;
  final int? supplierId;
  final String? date;
  final int? unitsPerPackaging;
  final int? stockId;
  final int? qty;
  final String? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const datummoves({
    this.id,
    this.status,
    this.notes,
    this.supplierId,
    this.date,
    this.unitsPerPackaging,
    this.stockId,
    this.qty,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory datummoves.fromJson(Map<String, dynamic> json) => datummoves(
        id: json['id'] as int?,
        status: json['status'] as int?,
        notes: json['notes'] as dynamic,
        supplierId: json['supplier_id'] as int?,
        date: json['date'] as String?,
        unitsPerPackaging: json['units_per_packaging'] as int?,
        stockId: json['stock_id'] as int?,
        qty: json['qty'] as int?,
        price: json['price'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'notes': notes,
        'supplier_id': supplierId,
        'date': date,
        'units_per_packaging': unitsPerPackaging,
        'stock_id': stockId,
        'qty': qty,
        'price': price,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      status,
      notes,
      supplierId,
      date,
      unitsPerPackaging,
      stockId,
      qty,
      price,
      createdAt,
      updatedAt,
    ];
  }
}

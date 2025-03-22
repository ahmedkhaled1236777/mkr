import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final int? stockId;
  final bool? status;
  final DateTime? date;
  final int? qty;
  final String? price;
  final dynamic nameOfSupplier;
  final dynamic notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const datummoves({
    this.id,
    this.stockId,
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
        stockId: json['stock_id'] as int?,
        status: json['status'] as bool?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
        qty: json['qty'] as int?,
        price: json['price'] as String?,
        nameOfSupplier: json['name_of_supplier'] as dynamic,
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
        'stock_id': stockId,
        'status': status,
        'date': date?.toIso8601String(),
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
      stockId,
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

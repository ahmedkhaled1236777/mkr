import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? image;
  final String? name;
  final String? priceUnit;
  final int? qty;
  final String? packagingType;
  final int? unitsPerPackaging;
  final int? warningQty;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Datum({
    this.id,
    this.image,
    this.name,
    this.priceUnit,
    this.qty,
    this.packagingType,
    this.unitsPerPackaging,
    this.warningQty,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        priceUnit: json['price_unit'] as String?,
        qty: json['qty'] as int?,
        packagingType: json['packaging_type'] as String?,
        unitsPerPackaging: json['units_per_packaging'] as int?,
        warningQty: json['warning_qty'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'price_unit': priceUnit,
        'qty': qty,
        'packaging_type': packagingType,
        'units_per_packaging': unitsPerPackaging,
        'warning_qty': warningQty,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      image,
      name,
      priceUnit,
      qty,
      packagingType,
      unitsPerPackaging,
      warningQty,
      createdAt,
      updatedAt,
    ];
  }
}

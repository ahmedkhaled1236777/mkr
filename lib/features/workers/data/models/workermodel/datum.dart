import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final double? totalHours;
  final int? totalSalary;

  const Datum({this.id, this.name, this.totalHours, this.totalSalary});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        totalHours: (json['total_hours'] as num?)?.toDouble(),
        totalSalary: json['total_salary'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'total_hours': totalHours,
        'total_salary': totalSalary,
      };

  @override
  List<Object?> get props => [id, name, totalHours, totalSalary];
}

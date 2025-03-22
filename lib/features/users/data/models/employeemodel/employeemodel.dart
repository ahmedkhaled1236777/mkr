import 'package:equatable/equatable.dart';

import 'datum.dart';

class Employeemodel extends Equatable {
  final bool? success;
  final String? message;
  final List<Datum>? data;

  const Employeemodel({this.success, this.message, this.data});

  factory Employeemodel.fromJson(Map<String, dynamic> json) => Employeemodel(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [success, message, data];
}

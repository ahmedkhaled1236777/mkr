import 'package:equatable/equatable.dart';

import 'datum.dart';

class Moneymodel extends Equatable {
  final bool? status;
  final String? message;
  final List<moneymoves>? data;

  const Moneymodel({this.status, this.message, this.data});

  factory Moneymodel.fromJson(Map<String, dynamic> json) => Moneymodel(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => moneymoves.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [status, message, data];
}

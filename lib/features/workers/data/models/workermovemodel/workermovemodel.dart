import 'package:equatable/equatable.dart';

import 'datum.dart';

class Workermovemodel extends Equatable {
  final bool? status;
  final String? message;
  final List<datamoves>? data;

  const Workermovemodel({this.status, this.message, this.data});

  factory Workermovemodel.fromJson(Map<String, dynamic> json) {
    return Workermovemodel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => datamoves.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [status, message, data];
}

import 'package:equatable/equatable.dart';

import 'datum.dart';
import 'link.dart';

class Suppliermovemodel extends Equatable {
  final bool? success;
  final String? message;
  final int? currentPage;
  final List<datummoves>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  const Suppliermovemodel({
    this.success,
    this.message,
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Suppliermovemodel.fromJson(Map<String, dynamic> json) {
    return Suppliermovemodel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => datummoves.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as dynamic,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'] as dynamic,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'current_page': currentPage,
        'data': data?.map((e) => e.toJson()).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'last_page': lastPage,
        'last_page_url': lastPageUrl,
        'links': links?.map((e) => e.toJson()).toList(),
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
        'total': total,
      };

  @override
  List<Object?> get props {
    return [
      success,
      message,
      currentPage,
      data,
      firstPageUrl,
      from,
      lastPage,
      lastPageUrl,
      links,
      nextPageUrl,
      path,
      perPage,
      prevPageUrl,
      to,
      total,
    ];
  }
}

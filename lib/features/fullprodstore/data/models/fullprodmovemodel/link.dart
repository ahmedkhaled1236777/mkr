import 'package:equatable/equatable.dart';

class Link extends Equatable {
  final dynamic url;
  final String? label;
  final bool? active;

  const Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json['url'] as dynamic,
        label: json['label'] as String?,
        active: json['active'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'label': label,
        'active': active,
      };

  @override
  List<Object?> get props => [url, label, active];
}

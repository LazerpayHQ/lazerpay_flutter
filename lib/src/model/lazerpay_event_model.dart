import 'dart:convert';

import 'package:equatable/equatable.dart';

class LazerPayEventModel with EquatableMixin {
  final String type;
  final dynamic data;
  LazerPayEventModel({
    required this.type,
    required this.data,
  });

  LazerPayEventModel copyWith({
    String? type,
    dynamic data,
  }) {
    return LazerPayEventModel(
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  Map<String, Object> toMap() {
    return {
      'type': type,
      'data': data,
    };
  }

  factory LazerPayEventModel.fromMap(Map<String, dynamic> map) {
    return LazerPayEventModel(
      type: map['type'] as String,
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LazerPayEventModel.fromJson(String source) =>
      LazerPayEventModel.fromMap(
        json.decode(source),
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, data ?? ''];
}

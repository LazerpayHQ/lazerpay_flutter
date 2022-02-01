import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Currency to be charged
enum LazerPayCurency { USD, NGN }

class LazerPayData with EquatableMixin {
  /// Your public key an be found on your dashboard settings
  final String publicKey;

  /// The users name
  final String name;

  /// This users email
  final String email;

  /// The amount
  final int amount;

  /// Lazerpay currency type
  final LazerPayCurency currency;

  /// Customers User reference
  final String reference;

  /// Lazerpay currency type as String
  String get currencyString => describeEnum(currency);

  bool get isProd => publicKey.contains('test') == false;

  LazerPayData({
    required this.publicKey,
    required this.name,
    required this.email,
    required this.amount,
    this.reference,
    this.currency = LazerPayCurency.NGN,
  });

  LazerPayData copyWith({
    String? publicKey,
    String? name,
    String? firstName,
    int? amount,
    LazerPayCurency? currency,
    String? reference,
    String? email,
  }) {
    return LazerPayData(
      publicKey: publicKey ?? this.publicKey,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      email: email ?? this.email,
      reference: reference ?? this.reference,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'publicKey': publicKey,
      'name': name,
      'amount': amount,
      'email': email,
      'reference': reference,
      'currency': describeEnum(currency),
    };
  }

  factory LazerPayData.fromMap(Map<String, dynamic> map) {
    return LazerPayData(
      publicKey: map['publicKey'],
      name: map['name'],
      amount: map['amount'],
      email: map['email'],
      reference: map['reference'],
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LazerPayData.fromJson(String source) =>
      LazerPayData.fromMap(json.decode(source));

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [
        publicKey,
        name,
        amount,
        email,
        reference,
        currency,
      ];
}

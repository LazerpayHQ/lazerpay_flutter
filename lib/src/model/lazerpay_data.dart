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

  /// Your business' businessLogo
  final String businessLogo;

  /// The amount
  final String amount;

  /// Lazerpay currency type
  final LazerPayCurency currency;

  /// Unique transaction reference
  final bool acceptPartialPayment;

  /// Accept partial payments
  final String reference;

  /// Lazerpay currency type as String
  String get currencyString => describeEnum(currency);

  bool get isProd => publicKey.contains('test') == false;

  LazerPayData({
    required this.publicKey,
    required this.name,
    required this.email,
    required this.amount,
    this.businessLogo = '',
    this.reference = '',
    this.acceptPartialPayment = false,
    this.currency = LazerPayCurency.NGN,
  });

  LazerPayData copyWith({
    String? publicKey,
    String? name,
    String? firstName,
    String? amount,
    LazerPayCurency? currency,
    String? reference,
    bool? acceptPartialPayment,
    String? email,
  }) {
    return LazerPayData(
      publicKey: publicKey ?? this.publicKey,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      email: email ?? this.email,
      businessLogo: email ?? this.businessLogo,
      reference: reference ?? this.reference,
      currency: currency ?? this.currency,
      acceptPartialPayment: acceptPartialPayment ?? this.acceptPartialPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'publicKey': publicKey,
      'name': name,
      if (businessLogo.isNotEmpty) 'businessLogo': businessLogo,
      'amount': amount,
      'email': email,
      'reference': reference,
      'currency': describeEnum(currency),
      'acceptPartialPayment': acceptPartialPayment,
    };
  }

  factory LazerPayData.fromMap(Map<String, dynamic> map) {
    return LazerPayData(
      name: map['name'],
      email: map['email'],
      amount: map['amount'],
      publicKey: map['publicKey'],
      businessLogo: map['businessLogo'] ?? '',
      reference: map['reference'],
      currency:
          map['currency'] == 'NGN' ? LazerPayCurency.NGN : LazerPayCurency.USD,
      acceptPartialPayment: map['acceptPartialPayment'],
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
        businessLogo,
        acceptPartialPayment,
      ];
}

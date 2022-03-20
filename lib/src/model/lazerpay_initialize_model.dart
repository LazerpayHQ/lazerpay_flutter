import 'dart:convert';

class LazerpayInitializeModel {
  final String message;
  final String status;
  final LazerpayInitializeData data;
  final int statusCode;
  LazerpayInitializeModel({
    required this.message,
    required this.status,
    required this.data,
    required this.statusCode,
  });

  LazerpayInitializeModel copyWith({
    String? message,
    String? status,
    LazerpayInitializeData? data,
    int? statusCode,
  }) {
    return LazerpayInitializeModel(
      message: message ?? this.message,
      status: status ?? this.status,
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
      'data': data.toMap(),
      'statusCode': statusCode,
    };
  }

  factory LazerpayInitializeModel.fromMap(Map<String, dynamic> map) {
    return LazerpayInitializeModel(
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      data: LazerpayInitializeData.fromMap(map['data']),
      statusCode: map['statusCode']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LazerpayInitializeModel.fromJson(String source) =>
      LazerpayInitializeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LazerpayInitializeModel(message: $message, status: $status, data: $data, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LazerpayInitializeModel &&
        other.message == message &&
        other.status == status &&
        other.data == data &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        status.hashCode ^
        data.hashCode ^
        statusCode.hashCode;
  }
}

class LazerpayInitializeData {
  final String reference;
  final String businessName;
  final String businessEmail;
  final String businessLogo;
  final String customerName;
  final String customerEmail;
  final String address;
  final String coin;
  final double cryptoAmount;
  final String currency;
  final int fiatAmount;
  final double feeInCrypto;
  final String network;
  final bool acceptPartialPayment;
  LazerpayInitializeData({
    required this.reference,
    required this.businessName,
    required this.businessEmail,
    required this.businessLogo,
    required this.customerName,
    required this.customerEmail,
    required this.address,
    required this.coin,
    required this.cryptoAmount,
    required this.currency,
    required this.fiatAmount,
    required this.feeInCrypto,
    required this.network,
    required this.acceptPartialPayment,
  });

  LazerpayInitializeData copyWith({
    String? reference,
    String? businessName,
    String? businessEmail,
    String? businessLogo,
    String? customerName,
    String? customerEmail,
    String? address,
    String? coin,
    double? cryptoAmount,
    String? currency,
    int? fiatAmount,
    double? feeInCrypto,
    String? network,
    bool? acceptPartialPayment,
  }) {
    return LazerpayInitializeData(
      reference: reference ?? this.reference,
      businessName: businessName ?? this.businessName,
      businessEmail: businessEmail ?? this.businessEmail,
      businessLogo: businessLogo ?? this.businessLogo,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      address: address ?? this.address,
      coin: coin ?? this.coin,
      cryptoAmount: cryptoAmount ?? this.cryptoAmount,
      currency: currency ?? this.currency,
      fiatAmount: fiatAmount ?? this.fiatAmount,
      feeInCrypto: feeInCrypto ?? this.feeInCrypto,
      network: network ?? this.network,
      acceptPartialPayment: acceptPartialPayment ?? this.acceptPartialPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'businessName': businessName,
      'businessEmail': businessEmail,
      'businessLogo': businessLogo,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'address': address,
      'coin': coin,
      'cryptoAmount': cryptoAmount,
      'currency': currency,
      'fiatAmount': fiatAmount,
      'feeInCrypto': feeInCrypto,
      'network': network,
      'acceptPartialPayment': acceptPartialPayment,
    };
  }

  factory LazerpayInitializeData.fromMap(Map<String, dynamic> map) {
    return LazerpayInitializeData(
      reference: map['reference'] ?? '',
      businessName: map['businessName'] ?? '',
      businessEmail: map['businessEmail'] ?? '',
      businessLogo: map['businessLogo'] ?? '',
      customerName: map['customerName'] ?? '',
      customerEmail: map['customerEmail'] ?? '',
      address: map['address'] ?? '',
      coin: map['coin'] ?? '',
      cryptoAmount: map['cryptoAmount']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? '',
      fiatAmount: map['fiatAmount']?.toInt() ?? 0,
      feeInCrypto: map['feeInCrypto']?.toDouble() ?? 0.0,
      network: map['network'] ?? '',
      acceptPartialPayment: map['acceptPartialPayment'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory LazerpayInitializeData.fromJson(String source) =>
      LazerpayInitializeData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(reference: $reference, businessName: $businessName, businessEmail: $businessEmail, businessLogo: $businessLogo, customerName: $customerName, customerEmail: $customerEmail, address: $address, coin: $coin, cryptoAmount: $cryptoAmount, currency: $currency, fiatAmount: $fiatAmount, feeInCrypto: $feeInCrypto, network: $network, acceptPartialPayment: $acceptPartialPayment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LazerpayInitializeData &&
        other.reference == reference &&
        other.businessName == businessName &&
        other.businessEmail == businessEmail &&
        other.businessLogo == businessLogo &&
        other.customerName == customerName &&
        other.customerEmail == customerEmail &&
        other.address == address &&
        other.coin == coin &&
        other.cryptoAmount == cryptoAmount &&
        other.currency == currency &&
        other.fiatAmount == fiatAmount &&
        other.feeInCrypto == feeInCrypto &&
        other.network == network &&
        other.acceptPartialPayment == acceptPartialPayment;
  }

  @override
  int get hashCode {
    return reference.hashCode ^
        businessName.hashCode ^
        businessEmail.hashCode ^
        businessLogo.hashCode ^
        customerName.hashCode ^
        customerEmail.hashCode ^
        address.hashCode ^
        coin.hashCode ^
        cryptoAmount.hashCode ^
        currency.hashCode ^
        fiatAmount.hashCode ^
        feeInCrypto.hashCode ^
        network.hashCode ^
        acceptPartialPayment.hashCode;
  }
}

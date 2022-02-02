# Flutter LazerPay

This package makes it easy to use the LazerPay in a flutter project.

## 📸 Screen Shots

<p float="left">
<img src="https://github.com/LazerPay-Finance/lazerpay_flutter/blob/main/1.png?raw=true" width="200">
<img src="https://github.com/LazerPay-Finance/lazerpay_flutter/blob/main/2.png?raw=true" width="200">
<img src="https://github.com/LazerPay-Finance/lazerpay_flutter/blob/main/3.png?raw=true" width="200">
<img src="https://github.com/LazerPay-Finance/lazerpay_flutter/blob/main/4.png?raw=true" width="200">
</p>

### 🚀 How to Use plugin

### Adding MaterialSupport

Add the dependency on Android’s Material in <my-app>/android/app/build.gradle:

```
dependencies {
    // ...
    implementation 'com.google.android.material:material:<version>'
    // ...
}
```

### LazerPay Send

- Launch LazerSendView in a bottom_sheet

```dart
import 'package:lazerpay_flutter/lazerpay_flutter.dart';

  void launch() async {
      await LazerPayView(
            data: LazerPayData(
               publicKey: "pk_live_...",
               reference: 'YOUR_REFERENCE', // Replace with a reference you generated
               name: "Chizo Ozioma",
               email: "test@gmail.com",
               amount: 1000,
               currency: LazerPayCurency.USD,
            ),
            showLogs: true,
            onClosed: () {
               print('closed');
               Navigator.pop(context);
            },
            onSuccess: (data) {
               print(data);
               Navigator.pop(context);
            },
            onError: print,
      ).show(context);
  }
```

- Use LazerPayView widget

```dart
import 'package:lazerpay_flutter/lazerpay_flutter.dart';

     ...

     LazerPayView(
         data: LazerPayData(
            publicKey: "pk_live_...",
            reference: 'YOUR_REFERENCE', // Replace with a reference you generated
            name: "Package Free",
            email: "test@gmail.com",
            amount: 1000,
            currency: LazerPayCurency.NGN,
         ),
         onClosed: () {
            Navigator.pop(context);
            print('Widget closed')
         },
         onSuccess: (data) {
            print(data);
            Navigator.pop(context);
         },
         onError: print,
        error: Text('Error'),
      )

      ...

```

The Transaction JSON returned for successful events

```ts
{
  "event": "successful",
  "data": {
    "id": "12896b32-0d7d-4744-bc15-5960af40d519",
    "reference": "aa6KlHy88D",
    "senderAddress": "0x0B4d358D349809037003F96A3593ff9015E89efA",
    "recipientAddress": "0x785F44E779cfEeDeBf7aA7CFde19DaA3312fd19e",
    "actualAmount": 10,
    "amountPaid": 10,
    "fiatAmount": 10,
    "coin": "BUSD",
    "currency": "USD",
    "hash": "0x3332d7b046d53e90dc0337c715252f210386c2a471c5025c953a0b1d9bc90593",
    "blockNumber": 14160827,
    "type": "received",
    "status": "confirmed",
    "network": "mainnet",
    "blockchain": "Binance Smart Chain",
    "customer": {
      "id": "b847dbbd-e5a4-4afc-ba26-b292707dc391",
      "customerName": "Njoku Emmanuel",
      "customerEmail": "kalunjoku123@gmail.com",
      "customerPhone": null,
      "network": "mainnet"
    }
  }
}
```

---

## ✨ Contribution

Lots of PR's would be needed to improve this plugin. So lots of suggestions and PRs are welcome.

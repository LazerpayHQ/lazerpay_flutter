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
               name: "Package Free",
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
--- 

## ✨ Contribution
 Lots of PR's would be needed to improve this plugin. So lots of suggestions and PRs are welcome.

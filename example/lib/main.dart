import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazerpay_flutter/lazerpay_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
      child: MaterialApp(
        title: 'Lazerpay Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Lazerpay Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          widget.title ?? '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: CupertinoButton(
                    color: lazerpayColor,
                    child: Center(
                      child: Text(
                        'Open Lazerpay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await LazerPayView(
                        data: LazerPayData(
                          acceptPartialPayment: true,
                          publicKey:
                              "pk_live_QiRW6zZYS2ik2FTvxazblo6aWRKRgiyavW37ZxJXl59sIKoyUh",
                          name: "Abdulfatai Suleiman",
                          email: "abdulfataisuleiman67@gmail.com",
                          amount: '1.5',
                          businessLogo:
                              'https://securecdn.pymnts.com/wp-content/uploads/2021/12/stablecoins.jpg',
                          currency: LazerPayCurency.USD,
                          metadata: {
                            'product_id': '324324324324',
                          },
                        ),
                        showLogs: true,
                        onInitialize: (data) {
                          print('initialized');
                        },
                        onSuccess: (data) {
                          print(data.toString());
                          Navigator.pop(context);
                        },
                        onClosed: () {
                          print('closed');
                          Navigator.pop(context);
                        },
                        onError: print,
                      ).show(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final lazerpayColor = Color(0xFF0066FF);

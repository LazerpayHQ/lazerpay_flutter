import 'package:lazerpay_flutter/lazerpay_flutter.dart';
import 'package:lazerpay_flutter/src/const/const.dart';

class LazerPayHtml {
  /// Raw mono html formation
  static String buildLazerPayHtml(LazerPayData data) => Uri.dataFromString('''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lazerpay</title>
    <script src="https://cdn.jsdelivr.net/gh/LazerPay-Finance/checkout-build@main/checkout%401.0.1/dist/index.min.js"type="text/javascript"></script>
</head>

<body onload="setupLazerCheckout()" style="border-radius: 20px; background-color:#fff;height:100vh;overflow: hidden; ">
    <script type="text/javascript">
        window.onload = setupLazerCheckout;
        function setupLazerCheckout() {

            // Override default JS Console function
            console._log_old = console.log
            console.log = function(msg) {
                sendMessageRaw(msg);
                console._log_old(msg);
            }

            console._error_old = console.error
            console.error = function(msg) {
                sendMessageRaw(msg);
                console._error_old(msg);
            }

            // Send callback to dart JSMessageClient
            function sendMessage(message) {
                if (window.LazerPayClientInterface && window.LazerPayClientInterface.postMessage) {
                    LazerPayClientInterface.postMessage(JSON.stringify(message));
                }
            }

            // Send raw callback to dart JSMessageClient
            function sendMessageRaw(message) {
                if (window.LazerPayClientInterface && window.LazerPayClientInterface.postMessage) {
                    LazerPayClientInterface.postMessage(message);
                }
            }

             LazerCheckout({
              name: "${data.name}",
              email: "${data.email}",
              amount: "${data.amount}",
              key: "${data.publicKey}",
              userReference: "${data.reference}",
              currency: "${data.currencyString}",
              onClose: (data) => sendMessage({
                    "type": "$ON_CLOSE",
                  }),
              onSuccess: (data) => sendMessage({
                    "type": "$ON_SUCCESS",
                    "data": { ...data },
                  }),
              onError: (data) => sendMessage({
                    "type": "$ON_ERROR",
                    "data": { ...data },
                  }),
            });


        }
    </script>
</body>

</html>
''', mimeType: 'text/html').toString();
}

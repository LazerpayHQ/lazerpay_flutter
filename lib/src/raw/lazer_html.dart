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
    <script src="https://js.lazerpay.finance/v1/index.min.js" type="text/javascript"></script>
</head>

<body onload="setupLazerCheckout()" style="border-radius: 20px; background-color:#fff;height:100vh;overflow: hidden; ">
    <script type="text/javascript">


        // Send callback to dart JSMessageClient
          function sendMessage(message) {
              if (window.LazerPayClientInterface && window.LazerPayClientInterface.postMessage) {
                  sendMessageRaw(JSON.stringify(message));
              }
          }

        // Send raw callback to dart JSMessageClient
          function sendMessageRaw(message) {
              if (window.LazerPayClientInterface && window.LazerPayClientInterface.postMessage) {
                  LazerPayClientInterface.postMessage(message);
              }
          }
        
        // Override JS Fetch
        (function (ns, fetch) {
          if (typeof fetch !== 'function') return;

          ns.fetch = function () {
            var out = fetch.apply(this, arguments);

            // side-effect

            out.then(async (ok) => {
              var data = await ok.clone().json();
              sendMessage({
                  "type": "$ON_FETCH",
                  "data": { ...data },
              })
            });

            return out;
          }

        }(window, window.fetch))

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

             LazerCheckout({
              name: "${data.name}",
              email: "${data.email}",
              amount: "${data.amount}",
              key: "${data.publicKey}",
              reference: "${data.reference}",
              acceptPartialPayment: ${data.acceptPartialPayment},
              currency: "${data.currencyString}",
              ${data.businessLogo.isNotEmpty ? 'businessLogo: "${data.businessLogo}",' : ''}
              metadata: ${data.metadata.isNotEmpty ? '${data.metadata}' : '{}'},
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

        // Add EventListener for onMessage Event
          window.addEventListener("click", (event) => {

          let path = event.composedPath()[0].innerHTML;
          if (path == "Copied" || path == "Copy")
              sendMessage({"type": "$ON_COPY", "data": path}) 
          });
        }
    </script>
</body>

</html>
''', mimeType: 'text/html').toString();
}

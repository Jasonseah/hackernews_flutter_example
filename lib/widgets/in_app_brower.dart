import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  void onLoadStart(String url) {
    super.onLoadStart(url);
    print("\n\nStarted $url\n\n");
  }

  @override
  void onLoadStop(String url) {
    super.onLoadStop(url);
    print("\n\nStopped $url\n\n");
  }

  @override
  void onExit() {
    super.onExit();
    print("\n\nBrowser closed!\n\n");
  }

  @override
  void onLoadError(String url, int code, String message) {
    print("url $url");
    print("code $code");
    print("message $message");
  }
}

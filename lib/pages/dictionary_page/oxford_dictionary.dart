import 'dart:async';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class OxfordDictionary extends StatefulWidget {
  const OxfordDictionary({super.key});

  @override
  State<OxfordDictionary> createState() => _OxfordDictionaryState();
}

class _OxfordDictionaryState extends State<OxfordDictionary> {
  bool _isLoading = true;
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_connectionStatus.toString() == "InternetStatus.disconnected") {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("لا يوجد اتصال بالانترنت!!"),
              SizedBox(
                height: 5,
              ),
              Text("لتشغيل القاموس تحتاج الي الاتصال بالانترنت!!"),
            ],
          ),
        ),
      );
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text(
            'القاموس',
            style: TextStyle(fontFamily: "bahja", color: Colors.white),
          ),
        ),
        body: kIsWeb
            ? Center(
                child: HtmlWidget(
                  '<iframe src="https://www.wordreference.com/enar/hello"></iframe>',
                  factoryBuilder: () => MyWidgetFactory(),
                ),
              )
            : InAppWebView(
                onLoadStop: (c, url) {},
                onLoadError:
                    (InAppWebViewController c, Uri? u, int, String l) {},
                onLoadStart: (InAppWebViewController controller, url) {},
                initialUrlRequest: URLRequest(
                    url: Uri.parse("https://www.wordreference.com/enar/hello")),
              ),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}

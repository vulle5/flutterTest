import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsWebView extends StatelessWidget {
  final String url;

  NewsWebView({this.url});

  @override
    Widget build(BuildContext context) {
      return WebviewScaffold(
        url: url,
        appBar: AppBar(title: Text(url),),
        allowFileURLs: false,
      );
    }
}
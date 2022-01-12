import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatelessWidget {
  final String url;
  final String authorName;
  WebViewScreen({this.url = '' , this.authorName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authorName ?? ''),
        centerTitle: true,
      ),
      body:  WebView(
        initialUrl: url ?? 'Not Valid Url' ,
      ),
    );
  }
}

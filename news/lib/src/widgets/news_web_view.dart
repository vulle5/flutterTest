import '../models/in_app_browser.dart';

class NewsWebView {
  final String url;

  NewsWebView({this.url});
  
  openWebView() async {
    await inAppBrowser.open(url: url);
  }
}

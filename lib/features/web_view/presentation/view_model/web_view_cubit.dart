import 'package:flowery/features/web_view/presentation/view_model/web_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCubit extends Cubit<WebViewState> {
  late final WebViewController controller;

  WebViewCubit(String url) : super(WebViewLoading()) {
    controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(
      NavigationDelegate(onPageFinished: (_) => emit(WebViewLoaded())),
    );
    controller.loadRequest(Uri.parse(url));
  }
}

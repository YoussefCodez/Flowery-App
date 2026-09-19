import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/web_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCubit extends Cubit<WebViewState> {
  late final WebViewController controller;

  WebViewCubit(String url, {WebViewController? testController})
      : super(WebViewLoading()) {
    controller = testController ?? WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.contains(Apikeys.successPayment)) {
              emit(PaymentSuccess());
              return NavigationDecision.prevent;
            }

            if (request.url.contains(Apikeys.goBacktoCart)) {
              emit(PaymentFailed());
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageFinished: (_) {
            emit(WebViewLoaded());
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}
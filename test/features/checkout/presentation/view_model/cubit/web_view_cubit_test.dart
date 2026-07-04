import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/web_view_cubit.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/web_view_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FakeJavaScriptMode extends Fake implements JavaScriptMode {}
class FakeNavigationDelegate extends Fake implements NavigationDelegate {}
class FakeUri extends Fake implements Uri {}

class MockWebViewController extends Mock implements WebViewController {}

void main() {
  late MockWebViewController mockController;

  setUpAll(() {
    registerFallbackValue(FakeJavaScriptMode());
    registerFallbackValue(FakeNavigationDelegate());
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockController = MockWebViewController();
  });

  void stubController() {
    when(() => mockController.setJavaScriptMode(any()))
        .thenAnswer((_) async {});

    when(() => mockController.setNavigationDelegate(any()))
        .thenAnswer((_) async {});

    when(() => mockController.loadRequest(any()))
        .thenAnswer((_) async {});
  }

  test('initial loadRequest is called', () {
    stubController();

    const url = 'https://example.com';

    final cubit = WebViewCubit(url, testController: mockController);

    verify(() => mockController.loadRequest(Uri.parse(url))).called(1);
    expect(cubit.state, isA<WebViewLoading>());
  });

  test('emits PaymentSuccess when success URL is detected', () {
    stubController();

    when(() => mockController.setNavigationDelegate(any()))
        .thenAnswer((invocation) {
      final delegate =
          invocation.positionalArguments.first as NavigationDelegate;

      delegate.onNavigationRequest?.call(
        NavigationRequest(
          url: 'https://test.com${Apikeys.successPayment}',
          isMainFrame: true,
        ),
      );

      return Future.value();
    });

    final cubit = WebViewCubit(
      'https://example.com',
      testController: mockController,
    );

    expect(cubit.state, isA<PaymentSuccess>());
  });

  test('emits PaymentFailed when cart URL is detected', () {
    stubController();

    when(() => mockController.setNavigationDelegate(any()))
        .thenAnswer((invocation) {
      final delegate =
          invocation.positionalArguments.first as NavigationDelegate;

      delegate.onNavigationRequest?.call(
        NavigationRequest(
          url: 'https://test.com${Apikeys.goBacktoCart}',
          isMainFrame: true,
        ),
      );

      return Future.value();
    });

    final cubit = WebViewCubit(
      'https://example.com',
      testController: mockController,
    );

    expect(cubit.state, isA<PaymentFailed>());
  });

  test('emits WebViewLoaded on page finished', () {
    stubController();

    when(() => mockController.setNavigationDelegate(any()))
        .thenAnswer((invocation) {
      final delegate =
          invocation.positionalArguments.first as NavigationDelegate;

      delegate.onPageFinished?.call('https://example.com');

      return Future.value();
    });

    final cubit = WebViewCubit(
      'https://example.com',
      testController: mockController,
    );

    expect(cubit.state, isA<WebViewLoaded>());
  });

  test('allows normal navigation', () {
    stubController();

    late FutureOr<NavigationDecision> decision;

    when(() => mockController.setNavigationDelegate(any()))
        .thenAnswer((invocation) {
      final delegate =
          invocation.positionalArguments.first as NavigationDelegate;

      decision = delegate.onNavigationRequest!(
        NavigationRequest(
          url: 'https://google.com',
          isMainFrame: true,
        ),
      );

      return Future.value();
    });

    WebViewCubit(
      'https://example.com',
      testController: mockController,
    );

    expect(decision, NavigationDecision.navigate);
  });
}
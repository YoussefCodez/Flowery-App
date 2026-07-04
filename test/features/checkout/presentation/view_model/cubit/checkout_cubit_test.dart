import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flowery/features/checkout/domain/entities/credit_order_entity.dart';
import 'package:flowery/features/checkout/domain/use_cases/checkout_cash_order_use_case.dart';
import 'package:flowery/features/checkout/domain/use_cases/checkout_credit_card_order_use_case.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flowery/features/checkout/presentation/view_model/events/checkout_events.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/checkout_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreditOrderUseCase extends Mock
    implements CheckoutCreditCardOrderUseCase {}

class MockCashOrderUseCase extends Mock implements CheckoutCashOrderUseCase {}

class FakeCreateCashOrderRequest extends Fake
    implements CreateCashOrderRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCreateCashOrderRequest());
  });

  late MockCreditOrderUseCase creditUseCase;
  late MockCashOrderUseCase cashUseCase;
  late CheckoutCubit viewModel;
  final ShippingAddress shippingAddress = ShippingAddress(
    street: 'test',
    phone: 'test',
    city: 'test',
    lat: 'test',
    long: 'test',
  );

  setUp(() {
    creditUseCase = MockCreditOrderUseCase();
    cashUseCase = MockCashOrderUseCase();

    viewModel = CheckoutCubit(creditUseCase, cashUseCase);
  });

  group('CheckoutViewModel', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits loading then success when checkout using cash succeeds',
      build: () {
        when(() => cashUseCase.call(any())).thenAnswer(
          (_) async => Success(data: CashOrderEntity(message: 'Success')),
        );

        return viewModel;
      },
      act: (bloc) => bloc.doEvent(
        CheckoutUsingCashEvent(
          request: CreateCashOrderRequest(shippingAddress: shippingAddress),
        ),
      ),
      expect: () => [
        CheckoutState(isLoading: true),
        CheckoutState(isLoading: false, message: 'Success', isDone: true),
      ],
      verify: (_) {
        verify(() => cashUseCase.call(any())).called(1);
      },
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits loading then error when checkout using cash fails',
      build: () {
        when(
          () => cashUseCase.call(any()),
        ).thenAnswer((_) async => Error(exception: Exception('Server Error')));

        return viewModel;
      },
      act: (bloc) => bloc.doEvent(
        CheckoutUsingCashEvent(
          request: CreateCashOrderRequest(shippingAddress: shippingAddress),
        ),
      ),
      expect: () => [
        CheckoutState(isLoading: true),
        isA<CheckoutState>()
            .having((e) => e.isLoading, 'isLoading', false)
            .having((e) => e.message, 'message', contains('Server Error')),
      ],
      verify: (_) {
        verify(() => cashUseCase.call(any())).called(1);
      },
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits loading then url then clears url when checkout using credit succeeds',
      build: () {
        when(() => creditUseCase.call()).thenAnswer(
          (_) async =>
              Success(data: CreditOrderEntity(url: 'https://stripe.com')),
        );

        return viewModel;
      },
      act: (bloc) => bloc.doEvent(CheckoutUsingCreditEvent()),
      expect: () => [
        CheckoutState(isLoading: true),
        CheckoutState(isLoading: false, url: 'https://stripe.com'),
        CheckoutState(url: ''),
      ],
      verify: (_) {
        verify(() => creditUseCase.call()).called(1);
      },
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits loading then stops loading when checkout using credit fails',
      build: () {
        when(
          () => creditUseCase.call(),
        ).thenAnswer((_) async => Error(exception: Exception()));

        return viewModel;
      },
      act: (bloc) => bloc.doEvent(CheckoutUsingCreditEvent()),
      expect: () => [
        CheckoutState(isLoading: true),
        CheckoutState(isLoading: false),
      ],
      verify: (_) {
        verify(() => creditUseCase.call()).called(1);
      },
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'changes payment method',
      build: () => viewModel,
      act: (bloc) => bloc.doEvent(ChangePaymentMethodEvent(true)),
      expect: () => [CheckoutState(isCreditCard: true)],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'toggles gift',
      build: () => viewModel,
      act: (bloc) => bloc.doEvent(ToggleGiftEvent(true)),
      expect: () => [CheckoutState(isGift: true)],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'selects address',
      build: () => viewModel,
      act: (bloc) => bloc.doEvent(SelectAddressEvent('Home')),
      expect: () => [CheckoutState(selectedAddress: 'Home')],
    );
  });
}

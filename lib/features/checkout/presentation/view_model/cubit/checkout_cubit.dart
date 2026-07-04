import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flowery/features/checkout/domain/entities/credit_order_entity.dart';
import 'package:flowery/features/checkout/domain/use_cases/checkout_cash_order_use_case.dart';
import 'package:flowery/features/checkout/domain/use_cases/checkout_credit_card_order_use_case.dart';
import 'package:flowery/features/checkout/presentation/view_model/events/checkout_events.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutCreditCardOrderUseCase _creditOrderUseCase;
  final CheckoutCashOrderUseCase _cashOrderUseCase;
  CheckoutCubit(this._creditOrderUseCase, this._cashOrderUseCase)
    : super(CheckoutState());

  void doEvent(CheckoutEvents event) {
    switch (event) {
      case CheckoutUsingCreditEvent():
        _checkoutUsingCredit();
      case CheckoutUsingCashEvent():
        _checkoutUsingCash(event);
      case ChangePaymentMethodEvent():
        _togglePaymentMethod(event.isCreditCard);
      case ToggleGiftEvent():
        _checkoutGift(event.isGift);
      case SelectAddressEvent():
        _selectAddress(event.selectedAddress);
    }
  }

  Future<void> _checkoutUsingCash(CheckoutUsingCashEvent event) async {
    emit(state.copyWith(isLoading: true));
    final response = await _cashOrderUseCase.call(event.request);

    switch (response) {
      case Success<CashOrderEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            message: response.data?.message,
            isDone: true,
          ),
        );
      case Error<CashOrderEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            message: response.exception.toString(),
          ),
        );
    }
  }

  Future<void> _checkoutUsingCredit() async {
    emit(state.copyWith(isLoading: true));
    final response = await _creditOrderUseCase.call();

    switch (response) {
      case Success<CreditOrderEntity>():
        emit(state.copyWith(isLoading: false, url: response.data?.url));
        emit(state.copyWith(url: ""));
      case Error<CreditOrderEntity>():
        emit(state.copyWith(isLoading: false));
    }
  }

  void _selectAddress(String? address) {
    emit(state.copyWith(selectedAddress: address));
  }

  void _togglePaymentMethod(bool? isCreditCard) {
    emit(state.copyWith(isCreditCard: isCreditCard));
  }

  void _checkoutGift(bool value) {
    emit(state.copyWith(isGift: value));
  }
}

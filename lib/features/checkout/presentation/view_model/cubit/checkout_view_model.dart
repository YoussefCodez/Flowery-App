import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/checkout/domain/entities/checkout_entity.dart';
import 'package:flowery/features/checkout/domain/use_cases/credit_checkout_session_use_case.dart';
import 'package:flowery/features/checkout/presentation/view_model/events/checkout_events.dart';
import 'package:flowery/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutViewModel extends Cubit<CheckoutState> {
  final CreditCheckoutSessionUseCase _creditCheckoutSessionUseCase;
  CheckoutViewModel(this._creditCheckoutSessionUseCase)
    : super(CheckoutState());

  void doEvent(CheckoutEvents event) {
    switch (event) {
      case CheckoutUsingCreditEvent():
        _checkoutCredit();
    }
  }

  Future<void> _checkoutCredit() async {
    emit(state.copyWith(isLoading: true));
    final response = await _creditCheckoutSessionUseCase.call();

    switch (response) {
      case Success<CheckoutEntity>():
        emit(state.copyWith(isLoading: false,url: response.data?.url));
      case Error<CheckoutEntity>():
      emit(state.copyWith(isLoading: false));
    }
  }
}

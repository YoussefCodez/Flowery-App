import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';

sealed class CheckoutEvents {}

class CheckoutUsingCreditEvent extends CheckoutEvents {}

class CheckoutUsingCashEvent extends CheckoutEvents {
  final CreateCashOrderRequest request;
  CheckoutUsingCashEvent({required this.request});
}

class ChangePaymentMethodEvent extends CheckoutEvents {
  final bool isCreditCard;
  ChangePaymentMethodEvent(this.isCreditCard);
}

class ToggleGiftEvent extends CheckoutEvents {
  final bool isGift;

  ToggleGiftEvent(this.isGift);
}

class SelectAddressEvent extends CheckoutEvents {
  final String? selectedAddress;

  SelectAddressEvent(this.selectedAddress);
}

sealed class CheckoutEvents {}

class CheckoutUsingCreditEvent extends CheckoutEvents {}

class CheckoutUsingCreditCardEvent extends CheckoutEvents {}

class CheckoutUsingCashEvent extends CheckoutEvents {}

class CheckoutUsingGiftEvent extends CheckoutEvents {}

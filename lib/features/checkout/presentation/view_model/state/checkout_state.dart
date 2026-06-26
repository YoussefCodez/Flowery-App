import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final bool isLoading;
  final bool isCreditCard;
  final bool isGift;
  final String? url;
  final String? selectedAddress;
  final String? message;
  final bool isDone;
  const CheckoutState({
    this.isLoading = false,
    this.isDone = false,
    this.isCreditCard = false,
    this.isGift = false,
    this.url,
    this.selectedAddress,
    this.message,
  });
  CheckoutState copyWith({
    final bool? isLoading,
    final bool? isDone,
    final bool? isCreditCard,
    final bool? isGift,
    final String? url,
    final String? selectedAddress,
    final String? message,
  }) => CheckoutState(
    isLoading: isLoading ?? this.isLoading,
    isDone: isDone ?? this.isDone,
    isCreditCard: isCreditCard ?? this.isCreditCard,
    isGift: isGift ?? this.isGift,
    url: url ?? this.url,
    selectedAddress: selectedAddress ?? this.selectedAddress,
    message: message ?? this.message,
  );
  @override
  List<Object?> get props => [
    isLoading,
    isCreditCard,
    isGift,
    url,
    selectedAddress,
    message,
  ];
}

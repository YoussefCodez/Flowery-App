import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final bool isLoading;
  final bool isCreditCard;
  final bool isGift;
  final String? url;
  const CheckoutState({
    this.isLoading = false,
    this.isCreditCard = false,
    this.isGift = false,
    this.url,
  });
  CheckoutState copyWith({
    final bool? isLoading,
    final bool? isCreditCard,
    final bool? isGift,
    final String? url,
  }) => CheckoutState(
    isLoading: isLoading ?? this.isLoading,
    isCreditCard: isCreditCard ?? this.isCreditCard,
    isGift: isGift ?? this.isGift,
    url: url ?? this.url,
  );
  @override
  List<Object?> get props => [isLoading, isCreditCard, isGift, url];
}

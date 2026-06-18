import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final bool isLoading;
  final String? url;
  const CheckoutState({this.isLoading = false, this.url});
  CheckoutState copyWith({final bool? isLoading, final String? url}) =>
      CheckoutState(
        isLoading: isLoading ?? this.isLoading,
        url: url ?? this.url,
      );
  @override
  List<Object?> get props => [isLoading, url];
}

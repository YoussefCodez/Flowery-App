import 'package:equatable/equatable.dart';

class CashOrderEntity extends Equatable {
  final String? message;

  const CashOrderEntity({this.message});

  @override
  List<Object?> get props => [message];
}

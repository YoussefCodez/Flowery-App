import 'package:equatable/equatable.dart';

class CreditOrderEntity extends Equatable{
  final String? url;
  const CreditOrderEntity({required this.url});
  
  @override
  List<Object?> get props => [url];
}

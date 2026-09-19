import 'package:equatable/equatable.dart';

class OrderInformation extends Equatable {
  final String? acceptedAt;
  final String? driverFirstName;
  final String? driverLastName;
  final String? driverPhoto;
  final String? driverPhoneNumber;

  const OrderInformation({
    required this.acceptedAt,
    required this.driverFirstName,
    required this.driverLastName,
    required this.driverPhoto,
    required this.driverPhoneNumber,
  });

  @override
  List<Object?> get props => [
    acceptedAt,
    driverFirstName,
    driverLastName,
    driverPhoto,
    driverPhoneNumber,
  ];
}

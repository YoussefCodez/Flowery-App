import 'package:equatable/equatable.dart';

class CoordinatesInformation extends Equatable {
  final double? userLat;
  final double? userLong;
  final double? driverLat;
  final double? driverLong;

  const CoordinatesInformation({
    required this.userLat,
    required this.userLong,
    required this.driverLat,
    required this.driverLong,
  });

  @override
  List<Object?> get props => [userLat, userLong, driverLat, driverLong];
}

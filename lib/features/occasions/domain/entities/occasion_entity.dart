import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class OccasionEntity extends Equatable {
  final String id;
  final String name;

  const OccasionEntity({required this.name, required this.id});

  @override
  List<Object?> get props => [id, name];
}

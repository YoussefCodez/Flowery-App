import 'package:equatable/equatable.dart';

class OccasionEntity extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final bool? isSuperAdmin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OccasionEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    image,
    isSuperAdmin,
    createdAt,
    updatedAt,
  ];
}
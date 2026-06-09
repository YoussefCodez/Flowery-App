import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;

  const CategoryEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, slug, image];
}

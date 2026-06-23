class ProductEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final double price;
  final double priceAfterDiscount;
  final double discount;
  final double rateAvg;
  final double rateCount;
  final int sold;
  final int quantity;
  final String category;
  final String occasion;
  final bool isSuperAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String productId;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.rateAvg,
    required this.rateCount,
    required this.sold,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt, required this.productId,
  });

}
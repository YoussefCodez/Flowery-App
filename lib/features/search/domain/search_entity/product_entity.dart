class ProductEntity {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? discount;
  final int? rateAvg;
  final int? rateCount;
  final int? sold;
  final int? quantity;
  final String? category;
  final String? occasion;
  final bool? isInWishlist;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isInWishlist,
    this.createdAt,
    this.updatedAt,
  });
}
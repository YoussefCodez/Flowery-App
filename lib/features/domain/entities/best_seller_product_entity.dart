class BestSellerProductEntity {
  final String imgCover;
  final String title;
  final String description;
  final int price;
  final int priceAfterDiscount;
  final int discount;
  final int quantity;
  final int? sold;
  final List<String> images;
  BestSellerProductEntity({
    required this.title,
    required this.description,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.quantity,
    required this.sold,
    required this.images,
  });
}
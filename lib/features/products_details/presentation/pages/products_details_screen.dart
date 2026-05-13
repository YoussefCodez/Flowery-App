import 'package:flutter/widgets.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  

  const ProductsDetailsScreen({super.key, required this.imageUrl, required this.title});
  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
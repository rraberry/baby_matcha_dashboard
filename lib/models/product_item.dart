class ProductItem {
  final String id;
  final String name;
  final String image;
  final String category;
  final int price;
  final int stock;
  final int sold;
  final bool trendingUp;

  const ProductItem({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.stock,
    required this.sold,
    required this.trendingUp,
  });
}
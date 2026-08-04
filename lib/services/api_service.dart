import '../models/product_item.dart';

class ApiService {
  static Future<List<ProductItem>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      ProductItem(
        id: "BM001",
        name: "Matcha Latte",
        image: "assets/images/matcha_latte.jpeg",
        category: "Matcha Beverage",
        price: 25000,
        stock: 45,
        sold: 128,
        trendingUp: true,
      ),

      ProductItem(
        id: "BM002",
        name: "Strawberry Matcha",
        image: "assets/images/strawberry_matcha.jpeg",
        category: "Matcha Beverage",
        price: 30000,
        stock: 12,
        sold: 95,
        trendingUp: true,
      ),

      ProductItem(
        id: "BM003",
        name: "Pink Matcha",
        image: "assets/images/pink_matcha.jpeg",
        category: "Matcha Beverage",
        price: 29000,
        stock: 30,
        sold: 72,
        trendingUp: true,
      ),

      ProductItem(
        id: "BM004",
        name: "Mango Matcha",
        image: "assets/images/mango_matcha.jpeg",
        category: "Matcha Beverage",
        price: 32000,
        stock: 18,
        sold: 64,
        trendingUp: true,
      ),

      ProductItem(
        id: "BM005",
        name: "Banana Matcha",
        image: "assets/images/banana_matcha.jpeg",
        category: "Matcha Beverage",
        price: 28000,
        stock: 15,
        sold: 58,
        trendingUp: true,
      ),

      ProductItem(
        id: "BM006",
        name: "Coconut Matcha",
        image: "assets/images/coconut_matcha.jpeg",
        category: "Matcha Beverage",
        price: 31000,
        stock: 5,
        sold: 44,
        trendingUp: false,
      ),

      ProductItem(
        id: "BM007",
        name: "Birthday Matcha",
        image: "assets/images/birthday_matcha.jpeg",
        category: "Matcha Beverage",
        price: 35000,
        stock: 22,
        sold: 180,
        trendingUp: true,
      ),

      ProductItem(
        id: "BM008",
        name: "Postre Matcha",
        image: "assets/images/postre_matcha.jpeg",
        category: "Matcha Beverage",
        price: 33000,
        stock: 16,
        sold: 53,
        trendingUp: true,
      ),
    ];
  }
}
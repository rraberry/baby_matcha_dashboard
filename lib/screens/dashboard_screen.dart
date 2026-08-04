import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product_item.dart';
import '../widgets/metric_card.dart';
import '../widgets/product_grid.dart';
import '../charts/sales_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late Future<List<ProductItem>> products;

  String searchText = "";
  String selectedFilter = "All";
  String selectedSort = "Highest Price";
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    products = ApiService.getProducts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          isDarkMode
              ? const Color(0xff1E1E1E)
              : const Color(0xffF8F8F2),

      appBar: AppBar(

        backgroundColor:
            isDarkMode
                ? const Color(0xff2B2B2B)
                : Colors.white,

        elevation: 0,

        title: const Text(
          "Baby Matcha",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(

            onPressed: () {

              setState(() {

                isDarkMode = !isDarkMode;

              });

            },

            icon: Icon(

              isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,

              color:
                  isDarkMode
                      ? Colors.amber
                      : Colors.black,

            ),

          ),

        ],

      ),

      body: FutureBuilder<List<ProductItem>>(

        future: products,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Image.asset(
                    "assets/images/loading.jpeg",
                    width: 180,
                  ),

                  const SizedBox(height: 20),

                  const CircularProgressIndicator(),

                  const SizedBox(height: 20),

                  const Text(
                    "Loading Baby Matcha...",
                  ),

                ],

              ),

            );

          }

          if (snapshot.hasError) {

            return Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Icon(
                    Icons.cloud_off,
                    size: 80,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Unable to load data",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Please try again.",
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(

                    onPressed: () {

                      setState(() {

                        products =
                            ApiService.getProducts();

                      });

                    },

                    child: const Text("Retry"),

                  ),

                ],

              ),

            );

          }

          final items = snapshot.data!;

          final filteredItems =
              items.where((product) {

            final matchSearch =
                product.name
                    .toLowerCase()
                    .contains(searchText);

            bool matchFilter = true;

            if (selectedFilter == "Best") {
              matchFilter =
                  product.sold >= 100;
            }

            if (selectedFilter == "Low") {
              matchFilter =
                  product.stock <= 15;
            }

            return matchSearch &&
                matchFilter;

          }).toList();

          if (selectedSort ==
              "Highest Price") {

            filteredItems.sort(
              (a, b) =>
                  b.price.compareTo(a.price),
            );

          }

          if (selectedSort ==
              "Lowest Price") {

            filteredItems.sort(
              (a, b) =>
                  a.price.compareTo(b.price),
            );

          }

          if (selectedSort ==
              "Most Sold") {

            filteredItems.sort(
              (a, b) =>
                  b.sold.compareTo(a.sold),
            );

          }

          if (selectedSort ==
              "Stock") {

            filteredItems.sort(
              (a, b) =>
                  b.stock.compareTo(a.stock),
            );

          }

          final screenWidth =
              MediaQuery.of(context)
                  .size
                  .width;

          final metricCrossAxis =
              screenWidth >= 900
                  ? 4
                  : screenWidth >= 600
                      ? 3
                      : 2;

          return ListView(

            padding:
                const EdgeInsets.all(16),

            children: [
                            Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "👋 Good Morning, Admin",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Today's Performance",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              TextField(

                onChanged: (value) {

                  setState(() {

                    searchText =
                        value.toLowerCase();

                  });

                },

                decoration: InputDecoration(

                  hintText:
                      "Search your favorite matcha...",

                  prefixIcon:
                      const Icon(Icons.search),

                  filled: true,

                  fillColor:
                      isDarkMode
                          ? Colors.grey.shade900
                          : Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(30),

                    borderSide:
                        BorderSide.none,

                  ),

                ),

              ),

              const SizedBox(height: 18),

              Row(

                children: [

                  FilterChip(

                    label:
                        const Text("All Drinks"),

                    selected:
                        selectedFilter == "All",

                    onSelected: (_) {

                      setState(() {

                        selectedFilter = "All";

                      });

                    },

                  ),

                  const SizedBox(width: 10),

                  FilterChip(

                    label:
                        const Text("Best Seller"),

                    selected:
                        selectedFilter == "Best",

                    onSelected: (_) {

                      setState(() {

                        selectedFilter = "Best";

                      });

                    },

                  ),

                  const SizedBox(width: 10),

                  FilterChip(

                    label:
                        const Text("Low Stock"),

                    selected:
                        selectedFilter == "Low",

                    onSelected: (_) {

                      setState(() {

                        selectedFilter = "Low";

                      });

                    },

                  ),

                ],

              ),

              const SizedBox(height: 20),

              Row(

                children: [

                  const Text(

                    "Sort By",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),

                  ),

                  const SizedBox(width: 15),

                  DropdownButton<String>(

                    value: selectedSort,

                    items: const [

                      DropdownMenuItem(
                        value: "Highest Price",
                        child: Text("Highest Price"),
                      ),

                      DropdownMenuItem(
                        value: "Lowest Price",
                        child: Text("Lowest Price"),
                      ),

                      DropdownMenuItem(
                        value: "Most Sold",
                        child: Text("Most Sold"),
                      ),

                      DropdownMenuItem(
                        value: "Stock",
                        child: Text("Stock"),
                      ),

                    ],

                    onChanged: (value) {

                      setState(() {

                        selectedSort = value!;

                      });

                    },

                  ),

                ],

              ),

              const SizedBox(height: 25),

              GridView.count(

                crossAxisCount:
                    metricCrossAxis,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                crossAxisSpacing: 12,

                mainAxisSpacing: 12,

                childAspectRatio: 2.3,

                children: [

                  MetricCard(

                    title: "Total Products",

                    value:
                        "${filteredItems.length}",

                    icon:
                        Icons.inventory_2_outlined,

                    color: Colors.green,

                  ),

                  MetricCard(

                    title: "Revenue",

                    value: "Rp 42.5M",

                    icon:
                        Icons.payments_outlined,

                    color: Colors.pink,

                  ),

                  MetricCard(

                    title: "Average Price",

                    value: "Rp 29.750",

                    icon:
                        Icons.sell_outlined,

                    color: Colors.orange,

                  ),

                  MetricCard(

                    title: "Total Sold",

                    value:
                        "${filteredItems.fold(0, (sum, item) => sum + item.sold)}",

                    icon:
                        Icons.shopping_cart_outlined,

                    color: Colors.blue,

                  ),

                ],

              ),

              const SizedBox(height: 30),

              const Text(

                "Weekly Sales",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,

                ),

              ),

              const SizedBox(height: 15),

              const SalesChart(),

              const SizedBox(height: 35),
                            const Text(
                "Top Selling Products",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage(items[0].image),
                  ),
                  title: Text(items[0].name),
                  subtitle: Text(
                    "Sold ${items[0].sold} cups",
                  ),
                  trailing: const Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage(items[1].image),
                  ),
                  title: Text(items[1].name),
                  subtitle: Text(
                    "Sold ${items[1].sold} cups",
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage(items[2].image),
                  ),
                  title: Text(items[2].name),
                  subtitle: Text(
                    "Sold ${items[2].sold} cups",
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Need Restock",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Card(
                color: const Color(0xffFFF8E1),
                child: ListTile(
                  leading: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                  title: const Text(
                    "Banana Matcha",
                  ),
                  subtitle: const Text(
                    "Only 8 cups left",
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Restock",
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Popular Products",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              if (filteredItems.isEmpty)

                Column(

                  children: [

                    const SizedBox(height: 20),

                    Image.asset(
                      "assets/images/no_sales.jpeg",
                      width: 180,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "No products found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                  ],

                )

              else

                ProductGrid(
                  products: filteredItems,
                ),

              const SizedBox(height: 40),

            ],

          );

        },

      ),

    );

  }

}
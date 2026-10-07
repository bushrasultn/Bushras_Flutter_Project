import 'package:flutter/material.dart';
import 'product_screen.dart';
import 'cart_screen.dart';

void main() {
  runApp(const MyApp());
}

// MyApp aik stateless widget hai jo poori app ki base configuration set karta hai
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Debug banner ko screen ke corner se hatane ke liye false kiya hai
      debugShowCheckedModeBanner: false,

      // App khulte hi sabse pehle HomeScreen nazar aayegi
      home: HomeScreen(),
    );
  }
}

// HomeScreen aik stateless widget hai jo main home screen ka design banata hai
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold screen ka aik standard structure deta hai, yahan halka off-white color lagaya hai
      backgroundColor: const Color(0xFFF8F9FA),

      // ================= LEFT SIDE NAVIGATION DRAWER (SUBMENU) =================
      // Yeh left side se khulne wala menu drawer hai jisme profile, product aur cart hain
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer ka header jahan user ki profile details nazar aayengi
            const UserAccountsDrawerHeader(
              accountName: Text("Bushra Sultan"),
              accountEmail: Text("bushrasultn@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.black87),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E2C), // Dark theme color header ke liye
              ),
            ),

            // 1. Profile option (Home screen par hi rehta hai ya drawer band ho jata hai)
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Menu ko band karne ke liye
              },
            ),

            // 2. Product option - Jab is par click ho toh Product screen par chale jao
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Product'),
              onTap: () {
                Navigator.pop(context); // Menu band karo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
                );
              },
            ),

            // 3. Cart option - Jab is par click ho toh Cart screen par chale jao
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context); // Menu band karo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
          ],
        ),
      ),

      // SafeArea yeh ensure karta hai ke content mobile ke notch ya status bar ke andar na jaye
      body: SafeArea(
        // SingleChildScrollView se screen scrollable ban jati hai taake overflow error na aaye
        child: SingleChildScrollView(
          // Poori screen ke charo taraf 20 pixels ka padding/gap diya gaya hai
          padding: const EdgeInsets.all(20.0),

          // Column widgets ko upar se neeche (vertical) arrange karta hai
          child: Column(
            // CrossAxisAlignment.start se saara text aur content left-aligned ho jata hai
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= TOP BAR SECTION =================
              // Row widgets ko aapas mein aik line mein (horizontal) rakhta hai
              Row(
                // MainAxisAlignment.spaceBetween items ko dono corners (left aur right) par phela deta hai
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // Left side par menu icon wala button jo Builder ke zariye drawer open karega
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black87),
                      onPressed: () {
                        // Left side wala drawer kholne ke liye
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),

                  // Right side par profile icon ke liye gol white container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle, // Container ko gol (circular) banata hai
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05), // Halki si shadow (chhaya)
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    // Gol box ke andar profile ka icon
                    child: IconButton(
                      icon: const Icon(Icons.person_outline, color: Colors.black87),
                      onPressed: () {}, // Filhal yeh bhi khali hai
                    ),
                  ),
                ],
              ),
              // Doosre section ke darmiyan 20 pixel ka vertical gap
              const SizedBox(height: 20),

              // ================= SEARCH BAR & CART ICON SECTION =================
              Row(
                children: [
                  // Expanded widget search bar ko bachi hui saari horizontal jagah de deta hai
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16), // Andar ki taraf padding
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30), // Search bar ke corners gol kiye hain
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      // Text input field jahan user search karega
                      child: const TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search, color: Colors.grey), // Search ka icon
                          hintText: "Search", // Placeholder text jo likha hua aayega
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none, // TextField ki default line ko khatam karta hai
                        ),
                      ),
                    ),
                  ),

                  // Search bar aur cart icon ke darmiyan 12 pixel ka fasla
                  const SizedBox(width: 12),

                  // InkWell tap/click hone ka effect deta hai
                  InkWell(
                    onTap: () {
                      // Jab cart icon par click ho toh user ko CartScreen par le jao
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                    // Cart icon ke liye gol white container
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      // Shopping bag ka icon orange accent color mein
                      child: const Icon(Icons.shopping_bag_outlined, color: Colors.deepOrangeAccent),
                    ),
                  ),
                ],
              ),

              // Neeche wale section ke liye 25 pixel ka gap
              const SizedBox(height: 25),

              // ================= EXPLORE HEADING =================
              const Text(
                "Explore",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              // Heading aur product list ke darmiyan 15 pixel ka gap
              const SizedBox(height: 15),

              // ================= HORIZONTAL PRODUCT CARD LIST =================
              SizedBox(
                height: 300, // ListView ki fixed height di hai taake cards fit aa sakein
                child: ListView(
                  scrollDirection: Axis.horizontal, // Cards ko left-to-right (horizontal) scrollable banata hai
                  children: [

                    // GestureDetector card par click event handle karne ke liye hai
                    GestureDetector(
                      onTap: () {
                        // Jab is product card par click ho toh ProductDetailScreen khul jaye
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
                        );
                      },

                      // Product ka main card container
                      child: Container(
                        width: 160, // Card ki width
                        padding: const EdgeInsets.all(12), // Card ke andar ki padding
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20), // Card ke corners gol kiye hain
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),

                        // Card ke andar cheezon ko vertical (upar se neeche) rakhne ke liye Column
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image ko gol corners dene ke liye ClipRRect ka istemal
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                // Working Unsplash image link jo direct image load karti hai
                                "https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?auto=format&fit=crop&w=500&q=60",
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover, // Image ko box mein fit karta hai bina stretch kiye
                              ),
                            ),
                            // Image aur product naam ke darmiyan gap
                            const SizedBox(height: 10),
                            // Product ka naam (Wooden Chair)
                            const Text(
                              "Wooden Chair",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            // Product ki choti subtitle / description
                            const Text(
                              "Modern Design",
                              style: TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                            // Spacer bachi hui saari jagah ko cover kar leta hai taake price wala row bilkul neechay chala jaye
                            const Spacer(),
                            // Price aur Add button ke liye Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Product ki price ($300.00)
                                const Text(
                                  "\$300.00",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                // Plus icon wala chota dark gol button
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1E1E2C), // Dark theme color
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
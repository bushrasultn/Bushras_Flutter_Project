import 'package:flutter/material.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Screen ka overall background white set kiya hai
      backgroundColor: Colors.white,

      // Stack widget ka use kiya hai taake elements aik dusre ke upar (layering mein) aa sakein
      body: Stack(
        children: [
          // --- 1. Background Header Area with Image (Upar wali badi product image aur header) ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // Screen ki total height ka 48% hissa image ke liye reserve kiya hai
            height: MediaQuery.of(context).size.height * 0.48,
            child: Container(
              color: Colors.grey[300],
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Stack(
                    children: [
                      // Background mein product ki image ko stretch karke fit kiya hai
                      Positioned.fill(
                        child: Image.network(
                          "https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?auto=format&fit=crop&w=800&q=60",
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Top par back button, title, aur cart icon ki row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Peeche (back) jane ke liye button
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                          // Top center mein screen ka title
                          const Text(
                            "Product",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          // Right side par cart screen par jane ke liye shopping bag icon
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CartScreen()),
                              );
                            },
                            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 26),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- 2. Floating Heart Icon (Favorite button jo image ke corner par floating hota hai) ---
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            right: 35,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                onPressed: () {},
              ),
            ),
          ),

          // --- 3. Content Details Panel (Neeche white rounded box jismein product ki saari details hain) ---
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
              // White container ke upar wale corners ko gol (rounded) kiya hai
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price, Name, aur Ratings wali row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side par Price aur Product ka Naam
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "\$300.00",
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "wooden Chair",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        // Right side par stars aur rating number (e.g. 4.5)
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star_half, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "4.5",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 24),

                    // "Color option" ka heading text
                    const Text(
                      "Color option",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 12),

                    // Colors select karne ke liye circles (Circles row)
                    Row(
                      children: [
                        // Selected color ke gird border show karne ke liye Container use kiya hai
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.deepOrangeAccent, width: 2),
                          ),
                          child: const CircleAvatar(radius: 10, backgroundColor: Colors.deepOrangeAccent),
                        ),
                        const SizedBox(width: 12),
                        const CircleAvatar(radius: 10, backgroundColor: Colors.grey),
                        const SizedBox(width: 12),
                        const CircleAvatar(radius: 10, backgroundColor: Colors.black87),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // "Description" heading text
                    const Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),

                    // Product ki tafseel (Description detail text)
                    const Text(
                      "It has a simple yet elegant design that makes it suitable for use at home, in the office, dining room, or study area. The chair is comfortable, well-maintained, and perfect for everyday use.",
                      style: TextStyle(color: Colors.grey, height: 1.5, fontSize: 13),
                    ),
                    const SizedBox(height: 80), // Neeche space di hai taake bottom sheet ke peeche text chup na jaye
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // --- 4. Add to Cart Bottom Action Bar (Screen ke bilkul neeche fixed Add to Cart button) ---
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Button dabane par user CartScreen par navigate ho jayega
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white, size: 18),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
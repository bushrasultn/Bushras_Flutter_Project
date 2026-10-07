import 'package:flutter/material.dart';

// ==========================================
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar screen ke upar header banata hai
      appBar: AppBar(
        // Title ko center mein karne ke liye true kiya hai
        centerTitle: true,
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Right side par cart wali tokri (icon) add ki hai
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              // Yahan aap cart icon ke click par koi action perform kar sakte hain
            },
          ),
        ],
      ),
      // Screen ka background color set kiya hai
      backgroundColor: const Color(0xFFF8F9FA),
      // Body ke andar saare elements ko padding di hai taake corners se thoda space rahe
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- Cart Item Tile (Product ki detail wala box) ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Product ki image ko rounded corners dene ke liye ClipRRect use kiya hai
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?auto=format&fit=crop&w=200&q=60",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Product ka naam aur price dikhane ke liye Expanded Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Wooden Chair",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$300.00",
                          style: TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // Item delete karne ke liye trash icon button
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Spacer ne item tile aur bill/checkout section ke darmiyan baqi sari jagah (space) khali chhor di hai
            const Spacer(),

            // --- Subtotal, Shipping & Total Section (Bill ka hisaab) ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: const [
                  // Subtotal wali row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text("\$300.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Shipping wali row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text("Free", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  // Dono sections ke beech mein ek seedhi line (Divider)
                  Divider(height: 20, thickness: 1),
                  // Total price wali row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("\$300.00", style: TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- Checkout Button ---
            SizedBox(
              width: double.infinity, // Button ko poori screen ki width tak phailane ke liye
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E2C), // Button ka dark background color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Gol corners
                ),
                onPressed: () {},
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
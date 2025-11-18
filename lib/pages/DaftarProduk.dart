import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_20/controller/DaftarProdukAPI_controller.dart';
import 'package:pas1_mobile_11pplg1_20/controller/Favorite_controller.dart';

class DaftarprodukAPI extends StatelessWidget {
  const DaftarprodukAPI({super.key});
  @override
  Widget build(BuildContext context) {
    final DaftarProdukAPIController controller = Get.put(DaftarProdukAPIController());
    final FavoritesController favCtrl = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk API'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final key = product['id'] ?? product['name'];

                return ListTile(
                  title: Text(product['name'] ?? 'Unnamed'),
                  subtitle: Text('Price: \$${product['price'] ?? 'N/A'}'),
                  onTap: () {
                    // Handle product tap
                  },
                  trailing: Obx(() {
                    final isFav = favCtrl.contains(key);
                    return IconButton(
                      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey),
                      onPressed: () => favCtrl.toggle(product),
                    );
                  }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
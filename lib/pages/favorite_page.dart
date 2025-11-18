import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_20/controller/Favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.find<FavoritesController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Favorit'),
        centerTitle: true,
      ),
      body: Obx(() {
        final favs = favCtrl.favorites;
        if (favs.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada favorit.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favs.length,
          itemBuilder: (context, index) {
            final product = favs[index];
            final key = (product['id'] ?? product['title']).toString();

            return Dismissible(
              key: ValueKey(key),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.redAccent,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                favCtrl.removeByKey(key);
                Get.snackbar(
                  "Deleted",
                  "${product['title']} removed from favorites",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              },
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product['image'] ?? 'https://via.placeholder.com/80',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  title: Text(
                    product['title'] ?? 'Unnamed',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Rp ${(product['price'] as num?)?.toStringAsFixed(2) ?? 'N/A'}',
                    style: const TextStyle(color: Colors.green, fontSize: 13),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => favCtrl.removeByKey(key),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

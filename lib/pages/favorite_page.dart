import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_20/controller/Favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favCtrl = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(title: const Text('Favorit')),
      body: Obx(() {
        final favs = favCtrl.favorites;
        if (favs.isEmpty) {
          return const Center(child: Text('Belum ada favorit.'));
        }
        return ListView.builder(
          itemCount: favs.length,
          itemBuilder: (context, index) {
            final product = favs[index];
            final key = product['id'] ?? product['name'];
            return ListTile(
              title: Text(product['name'] ?? 'Unnamed'),
              subtitle: Text('Price: \$${product['price'] ?? 'N/A'}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => favCtrl.removeByKey(key),
              ),
            );
          },
        );
      }),
    );
  }
}
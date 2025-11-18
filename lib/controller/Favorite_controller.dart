import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_20/db_helper.dart';

class FavoritesController extends GetxController {
  final RxList<Map<String, dynamic>> favorites = <Map<String, dynamic>>[].obs;
  final DbHelper _db = DbHelper();

  @override
  void onInit() {
    super.onInit();
    _loadFromDb();
  }

  Future<void> _loadFromDb() async {
    final rows = await _db.getFavorites();
    favorites.assignAll(rows);
  }

  dynamic _keyOf(Map<String, dynamic> product) => (product['id'] ?? product['name']).toString();

  Future<void> add(Map<String, dynamic> product) async {
    final key = _keyOf(product);
    if (!contains(key)) {
      await _db.insertFavorite(key, product, name: product['name']?.toString(), price: product['price'] != null ? double.tryParse(product['price'].toString()) : null);
      favorites.add(product);
    }
  }

  Future<void> removeByKey(dynamic key) async {
    final k = key.toString();
    await _db.deleteFavorite(k);
    favorites.removeWhere((p) => _keyOf(p) == k);
  }

  Future<void> toggle(Map<String, dynamic> product) async {
    final key = _keyOf(product);
    if (contains(key)) {
      await removeByKey(key);
    } else {
      await add(product);
    }
  }

  bool contains(dynamic key) => favorites.any((p) => _keyOf(p) == key);
}
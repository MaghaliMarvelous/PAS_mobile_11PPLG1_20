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
    favorites.assignAll(rows.map((p) => {
      'id': (p['id'] ?? p['id_str'] ?? p['key']).toString(),
      'title': p['title'] ?? p['name'],
      'price': p['price'],
      'image': p['image'],
    }));
  }

  String _keyOf(Map<String, dynamic> product) {
    final id = product['id'];
    return id?.toString() ?? '';
  }

  bool contains(dynamic key) {
    final k = key.toString();
    return favorites.any((p) => _keyOf(p) == k);
  }

  Future<void> add(Map<String, dynamic> product) async {
    final key = _keyOf(product);
    if (key.isEmpty || contains(key)) return;

    final normalized = {
      'id': key,
      'title': product['title'] ?? product['name'],
      'price': product['price'],
      'image': product['image'],
    };

    favorites.add(normalized);

    await _db.insertFavorite(
      key,
      normalized,
      name: normalized['title']?.toString(),
      price: normalized['price'] != null
          ? double.tryParse(normalized['price'].toString())
          : null,
    );
  }

  Future<void> removeByKey(dynamic key) async {
    final k = key.toString();
    favorites.removeWhere((p) => _keyOf(p) == k);
    await _db.deleteFavorite(k);
  }

  Future<void> toggle(Map<String, dynamic> product) async {
    final key = _keyOf(product);
    if (key.isEmpty) return;
    if (contains(key)) {
      await removeByKey(key);
    } else {
      await add(product);
    }
  }
}

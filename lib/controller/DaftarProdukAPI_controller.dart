import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/table.dart';

class DaftarProdukAPIController extends GetxController {
  var isLoading = false.obs;
  var produkList = <TableModel>[].obs;

  Future<List<TableModel>> fetchProduct() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        produkList.value = data.map((e) => TableModel.fromJson(e)).toList();
        return produkList;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

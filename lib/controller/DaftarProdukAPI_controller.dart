import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DaftarProdukAPIController extends GetxController {
  var isLoading = false.obs;
  var produkList = <Map<String, dynamic>>[].obs;


  Future<List<Map<String, dynamic>>> fetchProduct() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        produkList.value = data.map((e) => Map<String, dynamic>.from(e)).toList();
        return produkList;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
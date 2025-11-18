class ProductModel {
  final String key; // id or name as unique key
  final String? name;
  final double? price;
  final Map<String, dynamic> raw;

  ProductModel({
    required this.key,
    this.name,
    this.price,
    required this.raw,
  });

  factory ProductModel.fromMap(Map<String, dynamic> m) {
    final key = (m['id'] ?? m['name']).toString();
    return ProductModel(
      key: key,
      name: m['name']?.toString(),
      price: m['price'] != null ? double.tryParse(m['price'].toString()) : null,
      raw: m,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'name': name,
      'price': price,
      'raw': raw, // will be encoded when saving to db helper
    };
  }
}
import 'package:flutter/foundation.dart';
import 'package:korea_food/models/product_model.dart';
import 'package:korea_food/services/product_service.dart';

class ProductManager with ChangeNotifier {
  List<Product> _products = [];

  final ProductService _productsService;

  ProductManager() : _productsService = ProductService();

  Future<void> fetchProducts() async {
    _products = await _productsService.fetchProducts();
    notifyListeners();
  }

  // Future<void> updateTable(Table table) async {
  //   final index = _tables.indexWhere((item) => item.id == table.id);
  //   if (index >= 0) {
  //     if (await _tablesService.updateTable(table)) {
  //       _tables[index] = table;
  //       notifyListeners();
  //     }
  //   }
  // }

  List<Product> get products {
    return [..._products];
  }
}

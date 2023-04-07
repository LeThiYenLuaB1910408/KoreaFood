import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:korea_food/models/product_model.dart';
import '../../services/order_service.dart';

class OrderManager with ChangeNotifier {
  final OrderService _orderService = OrderService();
  List<Product> _products = [];
  int _total = 0;

  Future<void> fetchProductOrder(String id) async {
    _products = await _orderService.fetchProductOrder(id);

    notifyListeners();
  }

  Future<Map> sendOrder(
      List products, String manv, String so_ban, num total) async {
    return await _orderService.sendOrder(products, manv, so_ban, total);
  }

  Future<Map> updateOrder(
      List products, String manv, String so_ban, num total) async {
    return await _orderService.updateOrder(products, manv, so_ban, total);
  }

  Future<int> payment(List products, String manv, String so_ban, num total,
      String ma_giam_gia, String phuong_thuc_thanh_toan, int gia_tri_giam_gia, int so_luong) async {
    return await _orderService.payment(
        products, manv, so_ban, total, ma_giam_gia, phuong_thuc_thanh_toan,gia_tri_giam_gia, so_luong);
  }

  List<Product> get productsOrder {
    return [..._products];
  }

  int total(List<Product> products) {
    int total = 0;
    for (var element in products) {
      total += (element.so_luong_dat! * element.gia_mon_an);
    }
    return total;
  }
}

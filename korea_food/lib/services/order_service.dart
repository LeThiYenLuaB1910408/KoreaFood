import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';
import 'package:korea_food/models/product_model.dart';

class OrderService {
  Future<List<Product>> fetchProductOrder(String id) async {
    final List<Product> products = [];
    try {
      final productsUrl = Uri.http(Url, "/api/order/getOrder/$id");

      final response = await http.get(productsUrl);
      final productsMap = json.decode(response.body);
      if (response.statusCode != 200) {
        print(productsMap['error']);
        return products;
      }

      productsMap['danh_sach_mon_an'].forEach((product) {
        products.add(
          Product.fromJson(product),
        );
      });
      return products;
    } catch (error) {
      print(error);
      return products;
    }
  }

  Future sendOrder(List products, String manv, String so_ban, num total) async {
    try {
      final url = Uri.http(Url, "/api/order/sendorder");
      final response = await http.post(
        url,
        body: json.encode({
          'danh_sach_mon_an': products,
          'ma_nhan_vien_lap_don': manv,
          'so_ban': so_ban,
          'tong_tien': total
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {}
      return responseJson;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future updateOrder(
      List products, String manv, String so_ban, num total) async {
    try {
      final url = Uri.http(Url, "/api/order/updateorder");
      final response = await http.put(
        url,
        body: json.encode({
          'danh_sach_mon_an': products,
          'ma_nhan_vien_lap_don': manv,
          'so_ban': so_ban,
          'tong_tien': total
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {}
      return responseJson;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future payment(
    List products,
    String manv,
    String so_ban,
    num total,
    String ma_giam_gia,
    String phuong_thuc_thanh_toan,
    int gia_tri_giam_gia,
    int so_luong,
  ) async {
    print(phuong_thuc_thanh_toan);
    try {
      final url = Uri.http(Url, "/api/bill/payment");
      final response = await http.post(
        url,
        body: json.encode({
          'danh_sach_mon_an': products,
          'ma_nhan_vien_xuat_don': manv,
          'so_ban': so_ban,
          'tong_tien': total,
          'khuyen_mai_ap_dung': ma_giam_gia,
          'phuong_thuc_thanh_toan': phuong_thuc_thanh_toan,
          'gia_tri_giam_gia': gia_tri_giam_gia,
          'so_luong': so_luong
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {}
      return responseJson['so_hoa_don'];
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}

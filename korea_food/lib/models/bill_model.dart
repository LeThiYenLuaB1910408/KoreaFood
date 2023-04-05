import 'package:korea_food/models/product_model.dart';
import 'package:korea_food/models/table_model.dart';

class Bill {
  final String status, quantity, time, note, total;

  final List<Product> list_product;
  
  final String id_table, id_user;

  String? id;

  Bill({
    required this.id,
    required this.status,
    required this.quantity,
    required this.time,
    required this.note,
    required this.total,
    required this.list_product,
    required this.id_table,
    required this.id_user,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'id': id,
      'quantity': quantity,
      'time': time,
      'note': note,
      'total': total,
      'list_product': list_product,
      'id_table': id_table,
      'id_user': id_user,
    };
  }

  static Bill fromJson(Map<String, dynamic> json) {
    return Bill(
      status: json['status'],
      id: json['id'],
      quantity: json['quantity'],
      time: json['time'],
      note: json['note'],
      total: json['total'],
      list_product: json['list_product'],
      id_user: json['id_user'],
      id_table: json['id_table'],
    );
  }

  Bill copyWith({
    String? status,
    String? id,
    String? quantity,
    String? time,
    String? note,
    String? total,
    String? id_table,
    String? id_user,
    List<Product>? list_product,
  }) {
    return Bill(
      status: status ?? this.status,
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      time: time ?? this.time,
      note: note ?? this.note,
      total: total ?? this.total,
      id_user: id_user ?? this.id_user,
      id_table: id_table ?? this.id_table,
      list_product: list_product ?? this.list_product,
    );
  }
}

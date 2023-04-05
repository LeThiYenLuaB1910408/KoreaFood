import 'package:korea_food/models/product_model.dart';

class Order {
  final String status, quantity, time, note, total;
  final List<Product> list_product;
  String? id;

  Order({
    required this.id,
    required this.status,
    required this.quantity,
    required this.time,
    required this.note,
    required this.total,
    required this.list_product,
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
    };
  }

  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      status: json['status'],
      id: json['id'],
      quantity: json['quantity'],
      time: json['time'],
      note: json['note'],
      total: json['total'],
      list_product: json['list_product'],
    );
  }

  Order copyWith({
    String? status,
    String? id,
    String? quantity,
    String? time,
    String? note,
    String? total,
    List<Product>? list_product,
  }) {
    return Order(
      status: status ?? this.status,
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      time: time ?? this.time,
      note: note ?? this.note,
      total: total ?? this.total,
      list_product: list_product ?? this.list_product,
    );
  }
}

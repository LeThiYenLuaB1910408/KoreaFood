class Coupons {
  final String name, value;

  String? id;

  Coupons({
    required this.id,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'value': value,
    };
  }

  static Coupons fromJson(Map<String, dynamic> json) {
    return Coupons(
      name: json['name'],
      id: json['id'],
      value: json['value'],
    );
  }

  Coupons copyWith({
    String? name,
    String? id,
    String? value,
  }) {
    return Coupons(
      name: name ?? this.name,
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }
}

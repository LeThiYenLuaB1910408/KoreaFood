class Discount {
  final String ten_khuyen_mai, chi_tiet_khuyen_mai;
  final int gia_tri, rang_buoc;
  String? id;

  Discount(
      {this.id,
      required this.ten_khuyen_mai,
      required this.chi_tiet_khuyen_mai,
      required this.gia_tri,
      required this.rang_buoc});

  Map<String, dynamic> toJson() {
    return {
      'chi_tiet_khuyen_mai': chi_tiet_khuyen_mai,
      'ten_khuyen_mai': ten_khuyen_mai,
      'gia_tri': gia_tri,
      'rang_buoc': rang_buoc
    };
  }

  static Discount fromJson(Map<String, dynamic> json) {
    return Discount(
        id: json['_id'],
        chi_tiet_khuyen_mai: json['chi_tiet_khuyen_mai'],
        ten_khuyen_mai: json['ten_khuyen_mai'],
        gia_tri: json['gia_tri'],
        rang_buoc: json['rang_buoc']);
  }

  Discount copyWith(
      {String? id,
      String? chi_tiet_khuyen_mai,
      String? ten_khuyen_mai,
      int? gia_tri,
      int? rang_buoc}) {
    return Discount(
        id: id ?? this.id,
        chi_tiet_khuyen_mai: chi_tiet_khuyen_mai ?? this.chi_tiet_khuyen_mai,
        ten_khuyen_mai: ten_khuyen_mai ?? this.ten_khuyen_mai,
        gia_tri: gia_tri ?? this.gia_tri,
        rang_buoc: rang_buoc ?? this.rang_buoc);
  }
}

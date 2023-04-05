class TableModel {
  final String trang_thai_ban_an;
  final int so_cho_ngoi;
  String? id;

  TableModel({
    required this.id,
    required this.trang_thai_ban_an,
    required this.so_cho_ngoi,
  });

  Map<String, dynamic> toJson() {
    return {
      'trang_thai_ban_an': trang_thai_ban_an,
      'id': id,
      'so_cho_ngoi': so_cho_ngoi,
    };
  }

  static TableModel fromJson(Map<String, dynamic> json) {
    return TableModel(
      trang_thai_ban_an: json['trang_thai_ban_an'],
      id: json['id'],
      so_cho_ngoi: json['so_cho_ngoi'],
    );
  }

  TableModel copyWith({
    String? trang_thai_ban_an,
    String? id,
    int? so_cho_ngoi,
  }) {
    return TableModel(
      trang_thai_ban_an: trang_thai_ban_an ?? this.trang_thai_ban_an,
      id: id ?? this.id,
      so_cho_ngoi: so_cho_ngoi ?? this.so_cho_ngoi,
    );
  }
}

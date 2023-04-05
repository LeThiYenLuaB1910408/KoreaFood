class Product {
  final String ten_mon_an, hinh_anh_mon_an, id_loai_mon_an;
  final int gia_mon_an, so_luong_ban_ra, trang_thai_mon_an;
  String? id, ghi_chu;
  int? so_luong_dat;

  Product(
      {this.id,
      this.so_luong_dat = 0,
      this.ghi_chu = '',
      required this.ten_mon_an,
      required this.hinh_anh_mon_an,
      required this.gia_mon_an,
      required this.id_loai_mon_an,
      required this.so_luong_ban_ra,
      required this.trang_thai_mon_an});

  Map<String, dynamic> toJson() {
    return {
      'hinh_anh_mon_an': hinh_anh_mon_an,
      'ten_mon_an': ten_mon_an,
      'gia_mon_an': gia_mon_an,
      'id_loai_mon_an': id_loai_mon_an,
      'so_luong_ban_ra': so_luong_ban_ra,
      'trang_thai_mon_an': trang_thai_mon_an
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      hinh_anh_mon_an: json['hinh_anh_mon_an'],
      ten_mon_an: json['ten_mon_an'],
      gia_mon_an: json['gia_mon_an'],
      id_loai_mon_an: json['id_loai_mon_an'],
      trang_thai_mon_an: json['trang_thai_mon_an'],
      so_luong_ban_ra: json['so_luong_ban_ra'],
      so_luong_dat: 0,
      ghi_chu: '',
    );
  }

  Product copyWith({
    String? id,
    String? hinh_anh_mon_an,
    String? ten_mon_an,
    int? gia_mon_an,
    String? id_loai_mon_an,
    int? trang_thai_mon_an,
    int? so_luong_ban_ra,
    int? so_luong_dat,
    String? ghi_chu,
  }) {
    return Product(
      id: id ?? this.id,
      hinh_anh_mon_an: hinh_anh_mon_an ?? this.hinh_anh_mon_an,
      ten_mon_an: ten_mon_an ?? this.ten_mon_an,
      gia_mon_an: gia_mon_an ?? this.gia_mon_an,
      id_loai_mon_an: id_loai_mon_an ?? this.id_loai_mon_an,
      trang_thai_mon_an: trang_thai_mon_an ?? this.trang_thai_mon_an,
      so_luong_ban_ra: so_luong_ban_ra ?? this.so_luong_ban_ra,
      so_luong_dat: so_luong_dat ?? 0,
      ghi_chu: ghi_chu ?? '',
    );
  }
}

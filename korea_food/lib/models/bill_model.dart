import 'package:korea_food/models/product_model.dart';

class Bill {
  final String ma_nhan_vien_lap_don,
      ma_nhan_vien_xuat_don,
      khuyen_mai_ap_dung,
      phuong_thuc_thanh_toan,
      thoi_gian;

  final List<Product> danh_sach_mon_an;

  final int tong_tien, so_ban, tong_so_luong, gia_tri_giam_gia;
  String? id;

  Bill(
      {required this.id,
      required this.ma_nhan_vien_lap_don,
      required this.ma_nhan_vien_xuat_don,
      required this.khuyen_mai_ap_dung,
      required this.phuong_thuc_thanh_toan,
      required this.tong_tien,
      required this.gia_tri_giam_gia,
      required this.danh_sach_mon_an,
      required this.so_ban,
      required this.thoi_gian,
      required this.tong_so_luong});

  Map<String, dynamic> toJson() {
    return {
      'ma_nhan_vien_lap_don': ma_nhan_vien_lap_don,
      'id': id,
      'ma_nhan_vien_xuat_don': ma_nhan_vien_xuat_don,
      'khuyen_mai_ap_dung': khuyen_mai_ap_dung,
      'phuong_thuc_thanh_toan': phuong_thuc_thanh_toan,
      'tong_tien': tong_tien,
      'gia_tri_giam_gia': gia_tri_giam_gia,
      'danh_sach_mon_an': danh_sach_mon_an,
      'so_ban': so_ban,
      'thoi_gian': thoi_gian,
      'tong_so_luong': tong_so_luong
    };
  }

  static Bill fromJson(Map<String, dynamic> json) {
    List<Product> product = [];
    json['danh_sach_mon_an'].forEach((e) {
      product.add(Product.fromJson(e));
    });
    return Bill(
      ma_nhan_vien_lap_don: json['ma_nhan_vien_lap_don'],
      id: json['_id'],
      ma_nhan_vien_xuat_don: json['ma_nhan_vien_xuat_don'],
      khuyen_mai_ap_dung: json['khuyen_mai_ap_dung'],
      phuong_thuc_thanh_toan: json['phuong_thuc_thanh_toan'],
      tong_tien: json['tong_tien'],
      gia_tri_giam_gia: json['gia_tri_giam_gia'],
      danh_sach_mon_an: product,
      thoi_gian: json['thoi_gian'],
      tong_so_luong: json['tong_so_luong'],
      so_ban: json['so_ban'],
    );
  }

  Bill copyWith({
    String? ma_nhan_vien_lap_don,
    String? id,
    String? ma_nhan_vien_xuat_don,
    String? khuyen_mai_ap_dung,
    String? phuong_thuc_thanh_toan,
    int? tong_tien,
    int? gia_tri_giam_gia,
    int? so_ban,
    String? thoi_gian,
    int? tong_so_luong,
    List<Product>? danh_sach_mon_an,
  }) {
    return Bill(
      ma_nhan_vien_lap_don: ma_nhan_vien_lap_don ?? this.ma_nhan_vien_lap_don,
      id: id ?? this.id,
      ma_nhan_vien_xuat_don:
          ma_nhan_vien_xuat_don ?? this.ma_nhan_vien_xuat_don,
      khuyen_mai_ap_dung: khuyen_mai_ap_dung ?? this.khuyen_mai_ap_dung,
      phuong_thuc_thanh_toan:
          phuong_thuc_thanh_toan ?? this.phuong_thuc_thanh_toan,
      thoi_gian: thoi_gian ?? this.thoi_gian,
      tong_so_luong: tong_so_luong ?? this.tong_so_luong,
      so_ban: so_ban ?? this.so_ban,
      danh_sach_mon_an: danh_sach_mon_an ?? this.danh_sach_mon_an,
      tong_tien: tong_tien ?? this.tong_tien,
      gia_tri_giam_gia: gia_tri_giam_gia ?? this.gia_tri_giam_gia,
    );
  }
}

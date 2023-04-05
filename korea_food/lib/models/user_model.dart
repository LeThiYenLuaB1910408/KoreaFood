import 'package:korea_food/models/user_account.dart';

class User {
  final String ho_ten,
      cccd,
      gioi_tinh,
      dia_chi,
      so_dien_thoai,
      hinh_anh_tai_khoan;
  String? id;
  Account tai_khoan;
  DateTime ngay_sinh;

  User(
      {this.id,
      required this.ho_ten,
      required this.cccd,
      required this.ngay_sinh,
      required this.gioi_tinh,
      required this.dia_chi,
      required this.so_dien_thoai,
      required this.hinh_anh_tai_khoan,
      required this.tai_khoan});

  Map<String, dynamic> toJson() {
    return {
      'ho_ten': ho_ten,
      'cccd': cccd,
      'ngay_sinh': ngay_sinh.toString().split(' ').first,
      'gioi_tinh': gioi_tinh,
      'so_dien_thoai': so_dien_thoai,
      'dia_chi': dia_chi,
      'hinh_anh_tai_khoan': hinh_anh_tai_khoan,
      'tai_khoan': tai_khoan.toJson()
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    var date = json['ngay_sinh'].toString().split('-');
    return User(
        id: json['_id'],
        ho_ten: json['ho_ten'],
        cccd: json['cccd'],
        ngay_sinh: DateTime(
          int.parse(date[0]),
          int.parse(date[1]),
          int.parse(date[2]),
        ),
        gioi_tinh: json['gioi_tinh'],
        so_dien_thoai: json['so_dien_thoai'],
        dia_chi: json['dia_chi'],
        hinh_anh_tai_khoan: json['hinh_anh_tai_khoan'],
        tai_khoan: Account.fromJson(json['tai_khoan']));
  }

  User copyWith(
      {String? id,
      String? ho_ten,
      String? cccd,
      DateTime? ngay_sinh,
      String? gioi_tinh,
      String? so_dien_thoai,
      String? dia_chi,
      String? hinh_anh_tai_khoan,
      Account? tai_khoan}) {
    return User(
        id: id ?? this.id,
        ho_ten: ho_ten ?? this.ho_ten,
        cccd: cccd ?? this.cccd,
        ngay_sinh: ngay_sinh ?? this.ngay_sinh,
        gioi_tinh: gioi_tinh ?? this.gioi_tinh,
        so_dien_thoai: so_dien_thoai ?? this.so_dien_thoai,
        dia_chi: dia_chi ?? this.dia_chi,
        hinh_anh_tai_khoan: hinh_anh_tai_khoan ?? this.hinh_anh_tai_khoan,
        tai_khoan: tai_khoan ?? this.tai_khoan);
  }
}

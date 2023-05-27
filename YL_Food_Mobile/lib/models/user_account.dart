class Account {
  final String ten_dang_nhap, mat_khau, cap_quyen, ngay_bat_dau_lam_viec;

  Account(
      {required this.ten_dang_nhap,
      required this.mat_khau,
      required this.cap_quyen,
      required this.ngay_bat_dau_lam_viec});

  Map<String, dynamic> toJson() {
    return {
      'ten_dang_nhap': ten_dang_nhap,
      'mat_khau': mat_khau,
      'cap_quyen': cap_quyen,
      'ngay_bat_dau_lam_viec': ngay_bat_dau_lam_viec
    };
  }

  static Account fromJson(Map<String, dynamic> json) {
    return Account(
        mat_khau: json['mat_khau'],
        ten_dang_nhap: json['ten_dang_nhap'],
        cap_quyen: json['cap_quyen'],
        ngay_bat_dau_lam_viec: json['ngay_bat_dau_lam_viec']);
  }

  Account copyWith(
      {String? mat_khau,
      String? ten_dang_nhap,
      String? cap_quyen,
      String? ngay_bat_dau_lam_viec}) {
    return Account(
        mat_khau: mat_khau ?? this.mat_khau,
        ten_dang_nhap: ten_dang_nhap ?? this.ten_dang_nhap,
        cap_quyen: cap_quyen ?? this.cap_quyen,
        ngay_bat_dau_lam_viec:
            ngay_bat_dau_lam_viec ?? this.ngay_bat_dau_lam_viec);
  }
}

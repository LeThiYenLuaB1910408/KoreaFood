import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:korea_food/const.dart';
import 'package:korea_food/homepage.dart';
import 'package:korea_food/models/bill_model.dart';
import 'package:korea_food/models/managers/order_manager.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:korea_food/user.dart';
import 'package:provider/provider.dart';

class DetailInvoicePage extends StatefulWidget {
  final Bill bill;

  DetailInvoicePage({Key? key, required this.bill}) : super(key: key);

  @override
  State<DetailInvoicePage> createState() => _DetailInvoicePageState();
}

class _DetailInvoicePageState extends State<DetailInvoicePage> {
  final oCcy = NumberFormat("#,##0", "vi_VN");

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserManager>().user;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 225, 207, 41),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 9,
                        spreadRadius: -4,
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        )),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'KoreaFood',
                          style: TextStyle(
                              fontFamily: 'Dancing Script',
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            spreadRadius: -3),
                      ], borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserPage()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/${user.hinh_anh_tai_khoan}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              'Quán Ăn Hàn Quốc',
                              style: poppins.copyWith(fontSize: 16),
                            ),
                            Text(
                              'KoreaFood',
                              style: TextStyle(
                                  fontFamily: 'Dancing Script', fontSize: 40),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  'Đường 3/2 - TP. Cần Thơ',
                                  style: poppins.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone),
                                Text(
                                  '0276455663',
                                  style: poppins.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.5,
                        indent: 40,
                        endIndent: 40,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'HOÁ ĐƠN THANH TOÁN',
                        style: poppins.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Số HĐ: ${widget.bill.id}',
                            style: poppins.copyWith(fontSize: 14),
                          ),
                          Text(
                            'Bàn: ${widget.bill.so_ban}',
                            style: poppins.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.bill.thoi_gian}',
                                style: poppins.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Text(
                            'Nhân viên: ${user.ho_ten}',
                            style: poppins.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Center(
                                  child: Text(
                                    'Tên Món',
                                    style: poppins.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .15,
                                child: Center(
                                  child: Text(
                                    'Số lượng',
                                    style: poppins.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .2,
                                child: Center(
                                  child: Text(
                                    'Giá',
                                    style: poppins.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .25,
                                child: Center(
                                  child: Text(
                                    'Tổng Tiền',
                                    style: poppins.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: widget.bill.danh_sach_mon_an.length * 35,
                            child: ListView.builder(
                              itemCount: widget.bill.danh_sach_mon_an.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BillItem(
                                      context,
                                      '${widget.bill.danh_sach_mon_an[index].ten_mon_an}',
                                      widget.bill.danh_sach_mon_an[index]
                                          .so_luong_dat!,
                                      widget.bill.danh_sach_mon_an[index]
                                          .gia_mon_an,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: const Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Center(
                                  child: Text(
                                    'TỔNG CỘNG',
                                    style: poppins.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .15,
                                child: Center(
                                  child: Text(
                                    widget.bill.tong_so_luong.toString(),
                                    style: poppins.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .2,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .25,
                                child: Center(
                                  child: Text(
                                    '${oCcy.format(context.read<OrderManager>().total(widget.bill.danh_sach_mon_an))}đ',
                                    style: poppins.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 42),
                                width: MediaQuery.of(context).size.width * .5,
                                child: Text(
                                  'GIẢM GIÁ',
                                  style: poppins.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .25,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .25,
                                child: Center(
                                  child: Text(
                                    '${oCcy.format(context.read<OrderManager>().total(widget.bill.danh_sach_mon_an) * widget.bill.gia_tri_giam_gia / 100)}đ',
                                    style: poppins.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'TỔNG TIỀN THANH TOÁN',
                            style: poppins.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${oCcy.format(widget.bill.tong_tien)}đ',
                            style: poppins.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      Text(
                        'CẢM ƠN QUÝ KHÁCH, HẸN GẶP LẠI!!!',
                        style: TextStyle(
                            fontFamily: 'Dancing Script', fontSize: 25),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BillItem(
    BuildContext context,
    String name,
    int number,
    int price,
  ) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    name,
                    style: poppins.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .15,
          child: Center(
            child: Text(
              '$number',
              style: poppins.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .2,
          child: Center(
            child: Text(
              '${oCcy.format(price)}đ',
              style: poppins.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .25,
          child: Center(
            child: Text(
              '${oCcy.format(price * number)}đ',
              style: poppins.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:korea_food/const.dart';
import 'package:korea_food/homepage.dart';
import 'package:korea_food/models/product_model.dart';

class BillPage extends StatefulWidget {
  List<Product> productsBill;
  String tennv, so_ban, ma_hoa_don;
  int? gia_tri_khuyen_mai;
  int so_luong;
  num total;

  BillPage(
      {Key? key,
      this.gia_tri_khuyen_mai,
      required this.so_luong,
      required this.productsBill,
      required this.so_ban,
      required this.tennv,
      required this.total,
      required this.ma_hoa_don})
      : super(key: key);

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  final oCcy = NumberFormat("#,##0", "vi_VN");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                decoration: BoxDecoration(
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (ctx) => HomePage()),
                              (route) => false);
                        },
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 25,
                        )),
                    Expanded(
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
                      margin: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UserPage()));
                          },
                          child: Icon(
                            Icons.print_outlined,
                            color: Colors.white,
                            size: 25,
                          )),
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
                            'Số HĐ: ${widget.ma_hoa_don}',
                            style: poppins.copyWith(fontSize: 14),
                          ),
                          Text(
                            'Bàn: ${widget.so_ban}',
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
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}',
                                style: poppins.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Text(
                            'Nhân viên: ${widget.tennv}',
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
                            height: widget.productsBill.length * 35,
                            child: ListView.builder(
                              itemCount: widget.productsBill.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BillItem(
                                      context,
                                      '${widget.productsBill[index].ten_mon_an}',
                                      widget.productsBill[index].so_luong_dat!,
                                      widget.productsBill[index].gia_mon_an,
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
                                    widget.so_luong.toString(),
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
                                    '${oCcy.format(widget.total)}đ',
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
                                    '${oCcy.format(widget.total * widget.gia_tri_khuyen_mai! / 100)}đ',
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
                            '${oCcy.format(widget.total - widget.total * widget.gia_tri_khuyen_mai! / 100)}đ',
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

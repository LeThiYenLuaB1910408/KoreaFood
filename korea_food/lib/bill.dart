import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:korea_food/const.dart';
import 'package:korea_food/homepage.dart';
import 'package:korea_food/user.dart';

import 'dialog.dart';

class BillPage extends StatefulWidget {
  const BillPage({Key? key}) : super(key: key);

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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserPage()));
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
                            'Số HĐ: 001',
                            style: poppins.copyWith(fontSize: 14),
                          ),
                          Text(
                            'Bàn: Số 1',
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
                            'Nhân viên: Yến Lụa',
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
                                width: MediaQuery.of(context).size.width * .3,
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
                                width: MediaQuery.of(context).size.width * .2,
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
                                width: MediaQuery.of(context).size.width * .25,
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
                            constraints: BoxConstraints(maxHeight: 180),
                            child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BillItem(
                                      context,
                                      'KimBap',
                                      2,
                                      45000,
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
                                width: MediaQuery.of(context).size.width * .3,
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
                                width: MediaQuery.of(context).size.width * .2,
                                child: Center(
                                  child: Text(
                                    '10',
                                    style: poppins.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                                    '450.000đ',
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
                                padding: EdgeInsets.only(left: 12),
                                width: MediaQuery.of(context).size.width * .5,
                                child: Text(
                                  'GIẢM GIÁ HÓA ĐƠN',
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
                                    '0đ',
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
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'TỔNG TIỀN THANH TOÁN',
                            style: poppins.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '450.000đ',
                            style: poppins.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
          width: MediaQuery.of(context).size.width * .3,
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
          width: MediaQuery.of(context).size.width * .2,
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
          width: MediaQuery.of(context).size.width * .25,
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

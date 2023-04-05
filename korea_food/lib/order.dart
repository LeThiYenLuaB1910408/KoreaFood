import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:korea_food/dialog.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/managers/product_manager.dart';
import 'package:korea_food/models/product_model.dart';
import 'package:korea_food/models/table_model.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:korea_food/user.dart';
import 'package:provider/provider.dart';
import 'bill.dart';
import 'const.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, required this.table}) : super(key: key);
  final TableModel table;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController editingController = TextEditingController();
  bool _customTileExpanded = false;
  final oCcy = NumberFormat("#,##0", "vi_VN");
  late Future<void> _fetchProducts;
  List products = [];
  List productsOrder = [];
  num total = 0;

  Future<void> _refreshProduct(BuildContext context) async {
    await context.read<ProductManager>().fetchProducts();
    List product = context.read<ProductManager>().products;
    products.addAll(product);
  }

  @override
  void initState() {
    super.initState();
    _refreshProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserManager>().user;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Container(
          height: 60,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      'TOTAL: ',
                      style: poppins.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      // ignore: unnecessary_string_interpolations
                      '${oCcy.format(total)}',
                      style: poppins.copyWith(
                        fontSize: 22,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      'đ',
                      style: TextStyle(
                          fontFeatures: [const FontFeature.superscripts()],
                          fontSize: 18,
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
              widget.table.trang_thai_ban_an == "Trống"
                  ? Container(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 30, right: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red[600]),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'SEND ORDER',
                              style: poppins.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : widget.table.trang_thai_ban_an == "Đang chuẩn bị"
                      ? Container(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 30, right: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 225, 207, 41)),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'WAITING',
                                  style: poppins.copyWith(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 30, right: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => const BillPage()));
                                },
                                child: Text(
                                  'PAYMENT',
                                  style: poppins.copyWith(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
            ],
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 225, 207, 41),
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                    height: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 9,
                                  spreadRadius: -4,
                                ),
                              ]),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                      ),
                                      color: Color.fromARGB(255, 225, 207, 41),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * .85,
                                    padding: const EdgeInsets.only(left: 50),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'All View',
                                        style: poppins.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.only(
                                        topRight: const Radius.circular(20.0),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 225, 207, 41),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * .15,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              child: TextField(
                                controller: editingController,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    List dummySearchList =
                                        context.read<ProductManager>().products;
                                    List search = dummySearchList
                                        .where((element) =>
                                            element.ten_mon_an.contains(value))
                                        .toList();

                                    setState(() {
                                      products.clear();
                                      products.addAll(search);
                                    });
                                  } else {
                                    List initList =
                                        context.read<ProductManager>().products;
                                    setState(() {
                                      products.clear();
                                      products.addAll(initList);
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(55)),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: const Color.fromARGB(
                                        255, 105, 103, 103),
                                  ),
                                  labelStyle: poppins.copyWith(
                                      color: const Color.fromARGB(
                                          255, 137, 136, 136)),
                                  labelText: 'Search...',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      0.0,
                                      0.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: -5.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                              ),
                              height: MediaQuery.of(context).size.height * .55,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: products.length,
                                itemBuilder: (context, i) => ExpansionTile(
                                  title: SizedBox(
                                    height: 80,
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.asset(
                                                  'assets/images/${products[i].hinh_anh_mon_an}',
                                                  height: 80,
                                                  width: 80,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    products[i].ten_mon_an,
                                                    style: poppins.copyWith(
                                                        fontSize: 16,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 86, 84, 84),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Price: ',
                                                          style: poppins.copyWith(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  112,
                                                                  110,
                                                                  110))),
                                                      Text(
                                                        '${oCcy.format(products[i].gia_mon_an)}đ',
                                                        style: poppins.copyWith(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.add,
                                  ),
                                  onExpansionChanged: (bool expanded) {
                                    setState(() {
                                      _customTileExpanded = expanded;
                                      print(_customTileExpanded);
                                    });
                                  },
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                initialValue:
                                                    products[i].ghi_chu,
                                                onChanged: (value) {
                                                  setState(() {
                                                    products[i].ghi_chu = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                      Icons.edit,
                                                      color: Color.fromARGB(
                                                          255, 105, 103, 103),
                                                    ),
                                                    labelStyle:
                                                        poppins.copyWith(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                82,
                                                                81,
                                                                81)),
                                                    labelText: 'Notes',
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  products[i].so_luong_dat -= 1;
                                                  if (products[i].so_luong_dat <
                                                      0) {
                                                    products[i].so_luong_dat =
                                                        0;
                                                  }
                                                });
                                              },
                                              child: const Center(
                                                child: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: Colors.black,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                            Text(
                                                products[i]
                                                    .so_luong_dat
                                                    .toString(),
                                                style: TextStyle(fontSize: 20)),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  products[i].so_luong_dat += 1;
                                                });
                                              },
                                              child: const Icon(
                                                  Icons.add_circle_outline,
                                                  color: Colors.black,
                                                  size: 25),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.blue,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                total = 0;
                                                productsOrder.add(products[i]);
                                                for (var element
                                                    in productsOrder) {
                                                  total +=
                                                      element.so_luong_dat *
                                                          element.gia_mon_an;
                                                }
                                              });
                                            },
                                            child: Text(
                                              'Add',
                                              style: poppins.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                // separatorBuilder: ((context, index) =>
                                //     const Divider()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 225, 207, 41),
                    boxShadow: [
                      const BoxShadow(
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
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        )),
                    const Expanded(
                      child: Center(
                        child: const Text(
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
                      decoration: BoxDecoration(boxShadow: [
                        const BoxShadow(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Table ${widget.table.id}',
                  style: poppins.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: -5.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Center(
                            child: Text(
                              'Name',
                              style: poppins.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .35,
                          child: Center(
                            child: Text(
                              'Number',
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
                              'Price',
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: ListView.builder(
                        itemCount: productsOrder.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Dismissible(
                            key: const ValueKey(Icons.wifi_1_bar_sharp),
                            onDismissed: (direction) {},
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) {
                              return showConfirmDialog(
                                  context, 'Do you want to remove the food?');
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              child: const Icon(Icons.delete_outlined,
                                  color: Colors.white),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrderItem(
                                  context,
                                  productsOrder[i].ten_mon_an,
                                  productsOrder[i].so_luong_dat,
                                  productsOrder[i].gia_mon_an,
                                ),
                                Text(
                                  '(Notes: ${productsOrder[i].ghi_chu})',
                                  style: poppins.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget OrderItem(
    BuildContext context,
    String name,
    int number,
    int price,
  ) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .45,
          child: Center(
            child: Row(
              children: [
                Text(
                  name,
                  style: poppins.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .25,
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
          width: MediaQuery.of(context).size.width * .24,
          child: Center(
            child: Text(
              '${oCcy.format(price)}đ',
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

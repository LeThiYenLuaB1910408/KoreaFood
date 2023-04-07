import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:korea_food/dialog.dart';
import 'package:korea_food/homepage.dart';
import 'package:korea_food/models/discount_model.dart';
import 'package:korea_food/models/managers/discount_manager.dart';
import 'package:korea_food/models/managers/order_manager.dart';
import 'package:korea_food/models/managers/table_manager.dart';
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
  final oCcy = NumberFormat("#,##0", "vi_VN");
  List<Product> products = [];
  List<Product> productsOrder = [];
  List<Product> productsBill = [];
  List<Discount> discounts = [];
  int gia_tri_giam_gia = 0;
  String ma_giam_gia = '';
  String phuong_thuc_thanh_toan = 'Cash';

  num total = 0;

  Future<void> _refreshProduct(BuildContext context) async {
    await context.read<ProductManager>().fetchProducts();
    List<Product> product = context.read<ProductManager>().products;
    products.addAll(product);
  }

  Future<void> _refreshDiscount(BuildContext context) async {
    await context.read<DiscountManager>().fetchDiscounts();
    List<Discount> discount = context.read<DiscountManager>().discounts;
    discounts = [];
    discounts.addAll(discount);
  }

  Future<void> _refreshProductOrder(BuildContext context) async {
    await context.read<OrderManager>().fetchProductOrder(widget.table.id!);
    List<Product> product = context.read<OrderManager>().productsOrder;
    productsBill = [];
    productsBill.addAll(product);
  }

  @override
  void initState() {
    super.initState();
    _refreshProduct(context);
    _refreshProductOrder(context);
    _refreshDiscount(context);
  }

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserManager>().user;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavigation(user),
        floatingActionButton: FloatingActionButton(),
        body: Column(
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
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false);
                      },
                      icon: const Icon(
                        Icons.home,
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
                          color: Colors.black, blurRadius: 5, spreadRadius: -3),
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
                  ),
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
                    height: productsOrder.length * 67.5,
                    child: ListView.builder(
                      itemCount: productsOrder.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Dismissible(
                          key: const ValueKey(Icons.wifi_1_bar_sharp),
                          onDismissed: (direction) {
                            setState(() {
                              productsOrder.removeAt(i);
                            });
                          },
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
                              const Text(
                                'Thêm Mới',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              OrderItem(
                                context,
                                productsOrder[productsOrder.length - 1 - i]
                                    .ten_mon_an,
                                productsOrder[productsOrder.length - 1 - i]
                                    .so_luong_dat!,
                                productsOrder[productsOrder.length - 1 - i]
                                    .gia_mon_an,
                              ),
                              Text(
                                '(Notes: ${productsOrder[productsOrder.length - 1 - i].ghi_chu})',
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
                  FutureBuilder(
                    future: _refreshProductOrder(context),
                    builder: (context, snapshot) => SizedBox(
                      height: 53.5 * productsBill.length,
                      child: ListView.builder(
                        itemCount: productsBill.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderItem(
                                context,
                                productsBill[i].ten_mon_an,
                                productsBill[i].so_luong_dat!,
                                productsBill[i].gia_mon_an,
                              ),
                              Text(
                                '(Notes: ${productsBill[i].ghi_chu})',
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BottomNavigation(user) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'TOTAL: ',
                style: poppins.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                future: _refreshProductOrder(context),
                builder: (context, snapshot) => Text(
                  oCcy.format(context
                      .read<OrderManager>()
                      .total([...productsBill, ...productsOrder])),
                  style: poppins.copyWith(
                    fontSize: 22,
                    color: Colors.red,
                  ),
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
                        onPressed: () {
                          if (productsOrder.isNotEmpty) {
                            context.read<OrderManager>().sendOrder(
                                productsOrder,
                                user.id!,
                                widget.table.id!,
                                total);
                            context
                                .read<TablesManager>()
                                .updateTable(widget.table.id!, 'Đang chuẩn bị');
                            showSuccessDialogOrder(
                                context, 'GỬI ĐƠN HÀNG THÀNH CÔNG');
                          }
                        },
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
              : Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 15, right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 225, 207, 41)),
                      child: productsOrder.isNotEmpty
                          ? TextButton(
                              onPressed: () {
                                context.read<OrderManager>().updateOrder(
                                    [...productsBill, ...productsOrder],
                                    user.id!,
                                    widget.table.id!,
                                    context.read<OrderManager>().total(
                                        [...productsBill, ...productsOrder]));
                                context.read<TablesManager>().updateTable(
                                    widget.table.id!, "Đang chuẩn bị");
                                showSuccessDialogOrder(
                                    context, 'CẬP NHẬT ĐƠN HÀNG THÀNH CÔNG');
                              },
                              child: Text(
                                'UPDATE',
                                style: poppins.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 15, right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: widget.table.trang_thai_ban_an == 'Đang chuẩn bị'
                          ? TextButton(
                              onPressed: () {
                                context.read<TablesManager>().updateTable(
                                    widget.table.id!, 'Hoàn thành');
                                showSuccessDialogOrder(
                                    context, 'ĐƠN HÀNG HOÀN THÀNH');
                              },
                              child: Text(
                                'FINISH',
                                style: poppins.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Payment(user),
                    )
                  ],
                )
        ],
      ),
    );
  }

  Widget Payment(user) {
    return TextButton(
      onPressed: () {
        setState(() {
          total = context
              .read<OrderManager>()
              .total([...productsBill, ...productsOrder]);
        });
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, StateSetter stateSetter) => FutureBuilder(
                future: _refreshDiscount(context),
                builder: (context, snapshot) {
                  return Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                width: MediaQuery.of(context).size.width * .85,
                                padding: const EdgeInsets.only(left: 50),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Confirm Receipt',
                                    style: poppins.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                  ),
                                  color: Color.fromARGB(255, 225, 207, 41),
                                ),
                                width: MediaQuery.of(context).size.width * .15,
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
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: poppins.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${oCcy.format(context.read<OrderManager>().total([
                                      ...productsBill,
                                      ...productsOrder
                                    ]))}đ',
                                style: poppins.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Payment Methods',
                              style: poppins.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Payment Methods',
                              style: TextStyle(fontSize: 16),
                            ),
                            items: ['Cash', 'Credit Card']
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: 'Cash',
                            onChanged: (value) {
                              stateSetter(() {
                                phuong_thuc_thanh_toan = value.toString();
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 50,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Select Discount',
                              style: poppins.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Discount',
                              style: TextStyle(fontSize: 16),
                            ),
                            items: discounts
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.id,
                                      enabled: total >= item.rang_buoc,
                                      child: Text(
                                        '${item.ten_khuyen_mai} - ${item.chi_tiet_khuyen_mai}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              stateSetter(() {
                                var infor = discounts.firstWhere(
                                    (element) => element.id == value);
                                gia_tri_giam_gia = infor.gia_tri;
                                ma_giam_gia = infor.id!;
                                int temp = context
                                    .read<OrderManager>()
                                    .total([...productsBill, ...productsOrder]);
                                if (temp >= infor.rang_buoc) {
                                  total = total * (100 - infor.gia_tri) / 100;
                                } else {
                                  total = temp;
                                }
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 50,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      'TOTAL PAYMENT: ',
                                      style: poppins.copyWith(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      oCcy.format(total),
                                      style: poppins.copyWith(
                                        fontSize: 22,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const Text(
                                      'đ',
                                      style: TextStyle(fontFeatures: [
                                        FontFeature.superscripts()
                                      ], fontSize: 18, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 15, right: 15),
                                margin: const EdgeInsets.only(right: 15),
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green),
                                child: TextButton(
                                  onPressed: () async {
                                    int so_luong = 0;

                                    productsBill.forEach((element) {
                                      so_luong += element.so_luong_dat!;
                                    });
                                    int hd = await context
                                        .read<OrderManager>()
                                        .payment(
                                          productsBill,
                                          user.id!,
                                          widget.table.id!,
                                          total,
                                          ma_giam_gia,
                                          phuong_thuc_thanh_toan,
                                          gia_tri_giam_gia,
                                          so_luong
                                        );
                                    context
                                        .read<ProductManager>()
                                        .updateProduct(productsBill);
                                    context.read<TablesManager>().updateTable(
                                          widget.table.id!,
                                          'Trống',
                                        );
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => BillPage(
                                            ma_hoa_don: hd.toString(),
                                            productsBill: productsBill,
                                            tennv: user.ho_ten,
                                            gia_tri_khuyen_mai:
                                                gia_tri_giam_gia,
                                            so_ban: widget.table.id!,
                                            so_luong: so_luong,
                                            total: context
                                                .read<OrderManager>()
                                                .total(productsBill),
                                          ),
                                        ),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    'CONFIRM',
                                    style: poppins.copyWith(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      child: Text(
        'PAYMENT',
        style: poppins.copyWith(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget FloatingActionButton() {
    return Container(
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
              List<bool> customTileExpanded = [];
              for (var element in products) {
                customTileExpanded.add(false);
              }
              return StatefulBuilder(
                builder: (context, StateSetter setModal) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                    height: 550,
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
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                      ),
                                      color: Color.fromARGB(255, 225, 207, 41),
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
                                    List<Product> dummySearchList =
                                        context.read<ProductManager>().products;
                                    List<Product> search = dummySearchList
                                        .where((element) =>
                                            element.ten_mon_an.contains(value))
                                        .toList();

                                    setModal(() {
                                      products.clear();
                                      products.addAll(search);
                                    });
                                  } else {
                                    List<Product> initList =
                                        context.read<ProductManager>().products;
                                    setModal(() {
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
                                    color: Color.fromARGB(255, 105, 103, 103),
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
                              height: MediaQuery.of(context).size.height * .49,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: products.length,
                                itemBuilder: (context, i) => ExpansionTile(
                                  key: Key(i.toString()),
                                  initiallyExpanded: customTileExpanded[i],
                                  maintainState: customTileExpanded[i],
                                  title: SizedBox(
                                    height: 80,
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
                                                      color:
                                                          const Color.fromARGB(
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
                                  trailing: products[i].trang_thai_mon_an == 1
                                      ? Icon(
                                          !customTileExpanded[i]
                                              ? Icons.add
                                              : Icons.add_box_outlined,
                                        )
                                      : Image.asset(
                                          'assets/images/logo_soldout.webp',
                                          width: 80,
                                        ),
                                  onExpansionChanged: (bool expanded) {
                                    setModal(() {
                                      customTileExpanded[i] = expanded;
                                    });
                                  },
                                  children: products[i].trang_thai_mon_an == 1
                                      ? [
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
                                                        setModal(() {
                                                          products[i].ghi_chu =
                                                              value;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons.edit,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        105,
                                                                        103,
                                                                        103),
                                                              ),
                                                              labelStyle: poppins
                                                                  .copyWith(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          82,
                                                                          81,
                                                                          81)),
                                                              labelText:
                                                                  'Notes',
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setModal(() {
                                                        products[i]
                                                                .so_luong_dat =
                                                            products[i]
                                                                    .so_luong_dat! -
                                                                1;
                                                        if (products[i]
                                                                .so_luong_dat! <
                                                            0) {
                                                          products[i]
                                                              .so_luong_dat = 0;
                                                        }
                                                      });
                                                    },
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons
                                                            .remove_circle_outline,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                      products[i]
                                                          .so_luong_dat
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20)),
                                                  TextButton(
                                                    onPressed: () {
                                                      setModal(() {
                                                        products[i]
                                                                .so_luong_dat =
                                                            products[i]
                                                                    .so_luong_dat! +
                                                                1;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.add_circle_outline,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.blue,
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      total = 0;
                                                      if (products[i]
                                                              .so_luong_dat! >
                                                          0) {
                                                        productsOrder
                                                            .add(products[i]);
                                                      }
                                                      for (var element
                                                          in productsOrder) {
                                                        total += element
                                                                .so_luong_dat! *
                                                            element.gia_mon_an;
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    'Add',
                                                    style: poppins.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ]
                                      : [],
                                ),
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
          );
        },
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

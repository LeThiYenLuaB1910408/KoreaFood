import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:korea_food/bill.dart';
import 'package:korea_food/detail_invoice.dart';
import 'package:korea_food/models/bill_model.dart';
import 'package:korea_food/models/managers/bill_manager.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:provider/provider.dart';

import 'const.dart';

class InvoiceHistoryPage extends StatefulWidget {
  const InvoiceHistoryPage({Key? key}) : super(key: key);

  @override
  State<InvoiceHistoryPage> createState() => _InvoiceHistoryPageState();
}

class _InvoiceHistoryPageState extends State<InvoiceHistoryPage> {
  DateTime date = DateTime.now();
  List<Bill> bills = [];

  Future<void> _refreshBills(BuildContext context) async {
    User user = context.read<UserManager>().user;
    await context.read<BillsManager>().fetchBills(user.id);
    List<Bill> bill = context.read<BillsManager>().bills;
    bills = [];
    bills.addAll(bill);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 225, 207, 41),
        title: Text(
          "Invoice History",
          style: poppins.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 45,
                  margin: const EdgeInsets.only(left: 15, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050),
                      );
                      if (newDate == null) return;
                      setState(() {
                        date = newDate;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(date),
                          style: poppins.copyWith(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: _refreshBills(context),
            builder: (context, snapshot) => Container(
              height: MediaQuery.of(context).size.height * .78,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: bills.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.only(top: 8),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 195, 192, 192)),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          spreadRadius: -4,
                          blurStyle: BlurStyle.solid,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Số HĐ: ${bills[index].id}',
                                  style: poppins.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${bills[index].thoi_gian}',
                                  style: poppins.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'TỔNG TIỀN THANH TOÁN',
                              style: poppins.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${bills[index].tong_tien}đ',
                              style: poppins.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             DetailInvoicePage(bill: bills[index],)));
                              },
                              child: Text(
                                'Xem chi tiết ...',
                                style: poppins.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 20, 141, 239),
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

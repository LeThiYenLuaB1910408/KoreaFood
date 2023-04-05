import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:korea_food/config.dart';
import 'package:korea_food/const.dart';
import 'package:korea_food/models/managers/table_manager.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:korea_food/order.dart';
import 'package:provider/provider.dart';
import 'package:korea_food/user.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _fetchTables;
  late List tables;
  late User user;

  Future<void> _refreshTable(BuildContext context) async {
    await context.read<TablesManager>().fetchTables();
    tables = context.read<TablesManager>().tables;
  }

  Future<void> _refreshUser(BuildContext context) async {
    await context.read<UserManager>().fetchUser();
  }

  @override
  void initState() {
    super.initState();
    _refreshTable(context);
    _refreshUser(context);
    // try {
    //   // Configure socket transports must be sepecified
    //   socket = io(socketUrl, <String, dynamic>{
    //     'transports': ['websocket'],
    //   });

    //   // Connect to websocket
    //   socket.connect();

    //   // Handle socket events
    //   socket.on('connect', (_) => print('connect: ${socket.id}'));
    //   socket.on('location', (data) {
    //     print('location ' + data);
    //   });
    //   socket.on('typing', (data) {
    //     print('typing ' + data);
    //   });
    //   socket.emit("getTable");
    //   socket.on('getTable', (data) {
    //     tables = (data);
    //   });
    //   socket.on('disconnect', (_) => print('disconnect'));
    //   socket.on('fromServer', (_) => print(_));
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  late Socket socket;
  @override
  Widget build(BuildContext context) {
    user = context.read<UserManager>().user;
    // final tableManager = TablesManager();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(225, 207, 41, 1),
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
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(boxShadow: [
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
                                  builder: (context) => UserPage()));
                        },
                        child: FutureBuilder(
                            future: _refreshUser(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/images/${user.hinh_anh_tai_khoan}',
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(children: [
                        Icon(
                          Icons.circle,
                          color: Color.fromARGB(255, 197, 194, 194),
                        ),
                        Text(
                          'Empty',
                          style: poppins,
                        )
                      ]),
                    ),
                    Container(
                      child: Row(children: [
                        Icon(
                          Icons.circle,
                          color: Color.fromRGBO(225, 207, 41, 1),
                        ),
                        Text(
                          'Waiting...',
                          style: poppins,
                        )
                      ]),
                    ),
                    Container(
                      child: Row(children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                        ),
                        Text(
                          'Finished',
                          style: poppins,
                        )
                      ]),
                    )
                  ],
                ),
              ),
              FutureBuilder(
                  future: _refreshTable(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () => _refreshTable(context),
                      child: Consumer<TablesManager>(
                        builder: (context, tableManager, child) {
                          return SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.9 - 50,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              padding: EdgeInsets.all(20),
                              itemCount: tableManager.tables.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                              ),
                              itemBuilder: (ctx, i) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderPage(
                                              table: tableManager.tables[i])));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: tableManager.tables[i]
                                                  .trang_thai_ban_an ==
                                              'Trống'
                                          ? Color.fromARGB(255, 197, 194, 194)
                                          : tableManager.tables[i]
                                                      .trang_thai_ban_an ==
                                                  'Đang chuẩn bị'
                                              ? Color.fromRGBO(225, 207, 41, 1)
                                              : Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      'Table ${tableManager.tables[i].id}',
                                      style: poppins.copyWith(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

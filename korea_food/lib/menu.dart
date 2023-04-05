import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:korea_food/const.dart';
import 'package:korea_food/user.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 9,
                  spreadRadius: -4,
                ),
              ]),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    color: Color.fromARGB(255, 225, 207, 41),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Food Menu',
                        style: poppins.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Drinks Menu',
                        style: poppins.copyWith(
                            color: Color.fromARGB(255, 225, 207, 41),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(55)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 105, 103, 103),
                  ),
                  labelStyle: poppins.copyWith(
                      color: Color.fromARGB(255, 137, 136, 136)),
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
              height: MediaQuery.of(context).size.height * .75,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                padding: EdgeInsets.all(8),
                itemCount: 15,
                itemBuilder: (context, index) => ExpansionTile(
                  title: Container(
                    height: 80,
                    child: SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/images/Do_An/lau-cha-ca.jpg',
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Lẩu Chả Cá',
                                    style: poppins.copyWith(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 86, 84, 84),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text('Price: ',
                                          style: poppins.copyWith(
                                              color: Color.fromARGB(
                                                  255, 112, 110, 110))),
                                      Text(
                                        '199.000đ',
                                        style:
                                            poppins.copyWith(color: Colors.red),
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
                  trailing: Icon(
                    _customTileExpanded ? Icons.home : Icons.add,
                  ),
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 105, 103, 103),
                                    ),
                                    labelStyle: poppins.copyWith(
                                        color: Color.fromARGB(255, 82, 81, 81)),
                                    labelText: 'Notes',
                                    border: InputBorder.none),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              ),
                            ),
                            Text('1', style: TextStyle(fontSize: 20)),
                            TextButton(
                              onPressed: () {},
                              child: Icon(Icons.add_circle_outline,
                                  color: Colors.black, size: 25),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue,
                          child: TextButton(
                            onPressed: () {},
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
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                ),
                separatorBuilder: ((context, index) => const Divider()),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

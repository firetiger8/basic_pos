import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  double screenHeight = 0.0;
  double screenWidth = 0.0;
  double statusBarHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height; //552.8638200609188
    var screenWidth = MediaQuery.of(context).size.width; //961.5022957581195

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(width: 10), Text("Basic POS - Store ABC", style: const TextStyle(color: Colors.black, fontSize: 14))],
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            //** CENTER MENU */
            color: Colors.blueGrey,
            height: screenHeight,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Welcome Administrator"),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Material(
                        color: Colors.blueGrey[200],
                        child: InkWell(
                          splashColor: Colors.teal[100],
                          onTap: () {},
                          child: Container(
                              margin: const EdgeInsets.all(2),
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.2,
                              child: const Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                Icon(Icons.shopping_cart),
                                Text("POS", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),
                              ])),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Material(
                        color: Colors.blueGrey[200],
                        child: InkWell(
                          splashColor: Colors.teal[100],
                          onTap: () {},
                          child: Container(
                              margin: const EdgeInsets.all(2),
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.2,
                              child: const Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                Icon(Icons.inventory),
                                Text("Manage Product", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),
                              ])),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Material(
                        color: Colors.blueGrey[200],
                        child: InkWell(
                          splashColor: Colors.teal[100],
                          onTap: () {},
                          child: Container(
                              margin: const EdgeInsets.all(2),
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.2,
                              child: const Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                Icon(Icons.person),
                                Text("Manage User", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),
                              ])),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Material(
                        color: Colors.blueGrey[200],
                        child: InkWell(
                          splashColor: Colors.teal[100],
                          onTap: () {},
                          child: Container(
                              margin: const EdgeInsets.all(2),
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.2,
                              child: const Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                Icon(Icons.notes),
                                Text("Report", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),
                              ])),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "V 1.0",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          )),
    );
  }
}

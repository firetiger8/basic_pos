import 'package:flutter/material.dart';

import 'customer_list_widget.dart';

class CartHeaderWidget extends StatelessWidget {
  const CartHeaderWidget({Key? key}) : super(key: key);
  static const double RIGHT_LS_W = 0.25;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          padding: const EdgeInsets.all(4),
          width: screenWidth * RIGHT_LS_W,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                //ainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: constraints.maxWidth * 0.15,
                    width: constraints.maxWidth * 0.15,
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(32)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomerListScreen();
                              //return Text("abc");
                            });
                      },
                      icon: const Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxWidth * 0.15,
                    width: constraints.maxWidth * 0.15,
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(32)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.save,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxWidth * 0.15,
                    width: constraints.maxWidth * 0.15,
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(32)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Sav();
                              //return Text("abc");
                            });
                      },
                      icon: const Icon(
                        Icons.manage_search,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxWidth * 0.15,
                    width: constraints.maxWidth * 0.15,
                    decoration: BoxDecoration(color: AppConstant.accentColor, borderRadius: BorderRadius.circular(32)),
                    child: TextButton(
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                          title: const Text('Info Customer'),
                          content: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Customer yang dipilih : ",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text("Point :  PT", style: const TextStyle(fontSize: 12))
                                ],
                              )),
                          actions: [
                            TextButton(
                              child: const Text("Close"),
                              onPressed: null,
                            ),
                          ],
                        ));
                      },
                      child: Text(
                        "Cust 1",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: constraints.maxWidth * 0.15,
                    width: constraints.maxWidth * 0.15,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(32)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ));
    });
  }
}

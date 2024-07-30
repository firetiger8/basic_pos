// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';

import '../utils/currency_format.dart';

class CartTotalWidget extends StatelessWidget {
  CartTotalWidget({Key? key, required this.mode}) : super(key: key);
  var mode = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: const EdgeInsets.all(4),
          color: Colors.yellow,
          width: constraints.maxWidth,
          //height: sHeight * 0.5,
          child: Column(children: [
            Row(
              children: [
                const Text(
                  "Subtotal",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Spacer(),
                Text(
                  CurrencyFormat.convertToIdr(0, 0),
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: constraints.maxWidth * 0.94,
                    height: constraints.maxHeight * 0.5,
                    // color: Colors.pink,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "BAYAR",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white),
                      ),
                    )),
              ],
            ),
          ]),
        );
      },
    );
  }
}

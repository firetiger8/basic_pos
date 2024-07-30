import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CashRegisterPage extends StatelessWidget {
  CashRegisterPage({super.key});

  double screenHeight = 0.0;
  double screenWidth = 0.0;
  double statusBarHeight = 0.0;

  final kasAwalTextCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height; //552.8638200609188
    screenWidth = MediaQuery.of(context).size.width; //961.5022957581195

    Future<bool?> _showBackDialog() {
      return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Are you sure you want to leave this page?',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await _showBackDialog() ?? false;
          if (context.mounted && shouldPop) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 10), Text("Basic POS ", style: TextStyle(color: Colors.black, fontSize: 14))],
                ),
              ),
              body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: screenHeight,
                  width: screenWidth,
                  color: Colors.blueGrey,
                  //** CENTER MENU */
                  child: Center(
                    child: Container(
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.4,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "BUKA KASIR",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text("Hai, Kasir"),
                          SizedBox(
                            height: screenHeight * 0.08,
                            width: double.infinity,
                            child: TextFormField(
                              controller: kasAwalTextCont,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                isDense: true,
                                //contentPadding: EdgeInsets.only(top: 5, left: 10),
                                hintText: "Kas Awal",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.08,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0))),
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.blueGrey[700],
                                ),
                              ),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "BUKA KASIR",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}

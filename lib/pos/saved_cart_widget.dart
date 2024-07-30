import 'package:flutter/material.dart';

class SavedCartWidget extends StatelessWidget {
  const SavedCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
          height: sHeight * 0.8,
          width: sWidth * 0.7,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 2,
              blurRadius: 10,
              //offset: const Offset(0, 2), // changes position of shadow
            ),
          ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(32))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "PILIH TRANSAKSI",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Material(
                      //borderRadius: BorderRadius.circular(32),
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(32))),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ))),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.orange,
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
                  Expanded(
                    child: Text(
                      "ID",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "ITEM",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "JUMLAH",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "SELECTED",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "DELETE",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}

class SavedCartsItemWidget extends StatelessWidget {
  SavedCartsItemWidget(this.controller, this.index);

  var controller;
  var index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: index % 2 == 0 ? Colors.white : Colors.orange[100],
      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: Text(
            controller.loadedItems.elementAt(index)['id'].toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.loadedCartIntros.values.elementAt(index)['intro'],
                maxLines: 3,
                style: const TextStyle(fontSize: 10, letterSpacing: 0.5, overflow: TextOverflow.ellipsis),
              )),
        ),
        Expanded(
          child: Center(
              child: Text(
            controller.loadedCartIntros.values.elementAt(index)['count'].toString(),
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          )),
        ),
        Expanded(
            child: Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () => controller.selectSavedData(index),
            color: Colors.orange,
            icon: controller.selectedSavedCartIdx.value == index
                ? const Icon(Icons.check_circle)
                : Icon(
                    Icons.circle,
                    color: Colors.grey[600],
                  ),
          ),
        )),
        Expanded(
          child: Material(
              color: Colors.transparent,
              child: IconButton(
                  onPressed: () => null,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))),
        ),
      ]),
    );
  }
}

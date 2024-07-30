import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    Key? key,
    required this.mode,
  }) : super(key: key);
  var mode = 1; //mode =1 utk kasir, mode = 2 utk kasir mobile pos
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ElevatedButton(onPressed: null, child: Text("Kat 1")),
        ElevatedButton(onPressed: null, child: Text("Kat 1")),
        ElevatedButton(onPressed: null, child: Text("Kat 1")),
        ElevatedButton(onPressed: null, child: Text("Kat 1")),
        ElevatedButton(onPressed: null, child: Text("Kat 1")),
        ElevatedButton(onPressed: null, child: Text("Kat 1")),
        ElevatedButton(onPressed: null, child: Text("Kat 1")),
      ],
    );
    //***SHOW CATEGORY***
    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: controller.categoryMap.length,
    //   itemBuilder: (context, index) {
    //     return CategoryItemWidget(controller, index);
    //   },
    // );
  }
}

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget(
    this.controller,
    this.index,
  );

  var controller;
  var index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.getMitraSubCategory(controller.categoryMap.keys.elementAt(index)),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
            color: controller.selectedCatId == controller.categoryMap.keys.elementAt(index) ? Colors.orangeAccent : Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Text(
              "${controller.categoryMap.values.elementAt(index)['name']}".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  SubCategoryWidget(
    this.controller,
  );
  var controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SelectedCategoryWidget(controller),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: controller.mitraAvailableSubCat.length,
            itemBuilder: (context, index) {
              return SubCategoryItemWidget(controller, index);
            },
          ),
        ],
      ),
    );
  }
}

class SelectedCategoryWidget extends StatelessWidget {
  SelectedCategoryWidget(this.controller);

  var controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(children: [
          const SizedBox(
            width: 5,
          ),
          Text(
            controller.selectedCategory['name'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => controller.categoryUnselected(),
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
        ]));
  }
}

class SubCategoryItemWidget extends StatelessWidget {
  SubCategoryItemWidget(this.controller, this.index);

  var controller;
  var index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.getMitraAvailableProductBySubCat(controller.mitraAvailableSubCat[index]['key']),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: controller.selectedSubCatId == controller.mitraAvailableSubCat[index]['key'] ? Colors.orangeAccent : Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Center(
            child: Text(
          "${controller.mitraAvailableSubCat[index]['value']}".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: controller.selectedSubCatId == controller.mitraAvailableSubCat[index]['key'] ? Colors.white : Colors.green,
              fontSize: 10),
        )),
      ),
    );
  }
}

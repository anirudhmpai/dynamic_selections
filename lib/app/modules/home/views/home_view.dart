import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selections Assessment'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const CircularProgressIndicator()
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.jsonData['total_boxes'].toString(),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(border: Border.all()),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller.totalBoxController,
                          onChanged: (value) =>
                              controller.totalBoxValueChange(value),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.jsonData['total_selections'].toString(),
                          maxLines: 2,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(border: Border.all()),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller.totalSelectionsController,
                          onChanged: (value) =>
                              controller.totalSelectionsValueChange(value),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.jsonData['alphabets_allowed'].toString(),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(border: Border.all()),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller.totalAlphabetsController,
                          onChanged: (value) =>
                              controller.totalAlphabetsValueChange(value),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.jsonData['numbers_allowed'].toString(),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(border: Border.all()),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller.totalNumbersController,
                          onChanged: (value) =>
                              controller.totalNumbersValueChange(value),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [alphabetsListView(), numbersListView()],
                    ),
                  ),
                  bottomSection()
                ],
              ),
            )),
    );
  }

  Row bottomSection() {
    return Row(
      children: [
        TextButton(
          onPressed: () => controller.resetValues(),
          child: Container(
              height: 100,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(controller.jsonData['reset'].toString())),
        ),
        Expanded(
          child: Obx(() {
            return Container(
              height: 100,
              padding: const EdgeInsets.all(15),
              color: controller.statusText.toLowerCase().contains('success')
                  ? Colors.green
                  : Colors.red,
              child: Center(child: Text(controller.statusText.value)),
            );
          }),
        )
      ],
    );
  }

  Expanded numbersListView() {
    return Expanded(
      child: SizedBox(
        height: 100 * (controller.totalBoxCount.value + 1),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Checkbox(
                    value: controller.numbers[index],
                    onChanged: (value) =>
                        controller.numbersSelection(index, value),
                  );
                }),
                Text(
                  controller.jsonData['numbers'].toString().split(',')[index],
                ),
              ],
            );
          },
          itemCount: controller.totalBoxCount.value,
        ),
      ),
    );
  }

  Expanded alphabetsListView() {
    return Expanded(
      child: SizedBox(
        height: 100 * (controller.totalBoxCount.value + 1),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Checkbox(
                    value: controller.alphabets[index],
                    onChanged: (value) =>
                        controller.alphabetsSelection(index, value),
                  );
                }),
                Text(
                  controller.jsonData['alphabets'].toString().split('')[index],
                ),
              ],
            );
          },
          itemCount: controller.totalBoxCount.value,
        ),
      ),
    );
  }
}

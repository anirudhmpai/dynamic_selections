import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late Map<String, dynamic> jsonData;
  RxBool isLoading = true.obs;

  var totalBoxController = TextEditingController(text: '0');
  var totalSelectionsController = TextEditingController(text: '0');
  var totalAlphabetsController = TextEditingController(text: '0');
  var totalNumbersController = TextEditingController(text: '0');

  RxList<bool> alphabets = RxList.empty();
  RxList<bool> numbers = RxList.empty();
  RxInt alphabetsCount = 0.obs;
  RxInt numbersCount = 0.obs;
  RxInt totalBoxCount = 0.obs;
  RxInt totalSelectionsCount = 0.obs;
  RxInt totalAlphabetsCount = 0.obs;
  RxInt totalNumbersCount = 0.obs;

  RxString statusText = ''.obs;
  @override
  void onInit() {
    super.onInit();
    readJsonFile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> readJsonFile() async {
    final response =
        await rootBundle.loadString('assets/files/input_data.json');
    jsonData = await json.decode(response);
    isLoading.value = false;
    statusText.value = jsonData['success'].toString();
  }

  resetValues() {
    totalAlphabetsController.text = '0';
    totalBoxController.text = '0';
    totalNumbersController.text = '0';
    totalSelectionsController.text = '0';
    alphabetsCount.value = 0;
    numbersCount.value = 0;
    totalBoxCount.value = 0;
    totalSelectionsCount.value = 0;
    totalAlphabetsCount.value = 0;
    totalNumbersCount.value = 0;
  }

  numbersSelection(int index, bool? value) {
    if (numbersCount.value <= totalNumbersCount.value - 1 &&
        value! &&
        (alphabetsCount.value + numbersCount.value <=
            totalSelectionsCount.value - 1)) {
      numbers[index] = value;
      if (value) {
        numbersCount++;
      } else {
        numbersCount--;
      }
      statusText.value = jsonData['success'].toString();
    } else if (numbersCount.value <= totalNumbersCount.value && !value!) {
      numbers[index] = value;
      numbersCount--;
    } else {
      numbers[index] = !value!;
      if (alphabetsCount.value + numbersCount.value >=
          totalSelectionsCount.value) {
        statusText.value = jsonData['error3'].toString().replaceFirst(
              'input_value',
              totalSelectionsCount.value.toString(),
            );
      } else if (numbersCount.value >= totalNumbersCount.value) {
        statusText.value = jsonData['error2'].toString().replaceFirst(
              'input_value',
              totalNumbersCount.value.toString(),
            );
      }
    }
    refresh();
  }

  alphabetsSelection(int index, bool? value) {
    if (alphabetsCount.value <= totalAlphabetsCount.value - 1 &&
        value! &&
        (alphabetsCount.value + numbersCount.value <=
            totalSelectionsCount.value - 1)) {
      alphabets[index] = value;
      if (value) {
        alphabetsCount++;
      } else {
        alphabetsCount--;
      }
      statusText.value = jsonData['success'].toString();
    } else if (alphabetsCount.value <= totalAlphabetsCount.value && !value!) {
      alphabets[index] = value;
      alphabetsCount--;
    } else {
      alphabets[index] = !value!;
      if (alphabetsCount.value + numbersCount.value >=
          totalSelectionsCount.value) {
        statusText.value = jsonData['error3'].toString().replaceFirst(
              'input_value',
              totalSelectionsCount.value.toString(),
            );
      } else if (alphabetsCount.value >= totalAlphabetsCount.value) {
        statusText.value = jsonData['error1'].toString().replaceFirst(
              'input_value',
              totalAlphabetsCount.value.toString(),
            );
      }
    }
    refresh();
  }

  totalBoxValueChange(String value) {
    if (value == '' || value == '0') {
      totalBoxCount.value = 0;
    } else {
      final length = int.parse(value);
      if (length > 26) {
        statusText.value =
            jsonData['error7'].toString().replaceAll('input_value', '26');
        totalBoxCount.value = 0;
        numbersCount.value = 0;
        alphabetsCount.value = 0;
      } else if (length > 0) {
        alphabets.value = List.generate(length, (index) => false);
        numbers.value = List.generate(length, (index) => false);
        totalBoxCount.value = length;
      }
    }
    numbersCount.value = 0;
    alphabetsCount.value = 0;
  }

  totalSelectionsValueChange(String value) {
    if (value == '' || value == '0') {
      totalSelectionsCount.value = 0;
      statusText.value = jsonData['success'].toString();
    } else {
      totalSelectionsCount.value = int.parse(value);
      if (totalSelectionsCount.value > totalBoxCount.value * 2) {
        statusText.value = jsonData['error4']
            .toString()
            .replaceFirst('input_value', (totalBoxCount.value * 2).toString());
      } else {
        statusText.value = jsonData['success'].toString();
      }
    }
  }

  totalAlphabetsValueChange(String value) {
    if (value == '' || value == '0') {
      totalAlphabetsCount.value = 0;
      statusText.value = jsonData['success'].toString();
    } else {
      totalAlphabetsCount.value = int.parse(value);
      if (totalAlphabetsCount.value > totalSelectionsCount.value) {
        statusText.value = jsonData['error5']
            .toString()
            .replaceFirst('input_value', totalSelectionsCount.value.toString());
      } else {
        statusText.value = jsonData['success'].toString();
      }
    }
    alphabetsCount.value = 0;
  }

  totalNumbersValueChange(String value) {
    if (value == '' || value == '0') {
      totalNumbersCount.value = 0;
      statusText.value = jsonData['success'].toString();
    } else {
      totalNumbersCount.value = int.parse(value);
      if (totalNumbersCount.value > totalSelectionsCount.value) {
        statusText.value = jsonData['error6']
            .toString()
            .replaceFirst('input_value', totalSelectionsCount.value.toString());
      } else {
        statusText.value = jsonData['success'].toString();
      }
    }
    numbersCount.value = 0;
  }
}

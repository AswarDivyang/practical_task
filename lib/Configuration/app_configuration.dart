import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future getDisplayAlert(
  String title,
  String content,
) async {
  await Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Text(title),
        content: Text(content),
        actions: [
          MaterialButton(
            child: const Text("Ok"),
            onPressed: () {
              Get.back();
              Get.focusScope?.unfocus();
            },
          )
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

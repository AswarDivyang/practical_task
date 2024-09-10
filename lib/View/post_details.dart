import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator/Controller/post_details_controller.dart';

class PostDetails extends GetView<PostDetailController> {
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Posts Details')),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.postdata.value.title ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(controller.postdata.value.body ?? ""),
              ],
            ),
          );
        }));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator/Controller/postController.dart';
import 'package:knovator/Helper/routes.dart';
import 'package:knovator/Model/postmodel.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostListScreen extends GetView<PostDataController> {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            Post post = controller.posts[index];
            return PostCard(
              post: post,
              onTap: () {
                controller.markAsRead(post.id);
                controller.stopTimer(post.id);
                Get.toNamed(Routes.postDetails, arguments: post.id);
              },
            );
          },
        );
      }),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final PostDataController postController = Get.find();

    return VisibilityDetector(
      key: Key(post.id.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          postController.startTimer(post.id);
        } else {
          postController.stopTimer(post.id);
        }
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: post.isRead ? Colors.white : Colors.yellow[100],
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Text('${post.timerDuration}s'),
                    const SizedBox(width: 10),
                    const Icon(Icons.timer),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

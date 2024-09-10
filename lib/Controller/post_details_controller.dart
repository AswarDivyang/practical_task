import 'dart:convert';

import 'package:get/get.dart';
import 'package:knovator/Configuration/app_configuration.dart';
import 'package:knovator/Model/postmodel.dart';
import 'package:http/http.dart' as http;

class PostDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      postid = Get.arguments;
    }
    fetchPostDetails(postid ?? 0);
  }

  var postdata = Post().obs;
  int? postid;
  Future fetchPostDetails(int postId) async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));
      if (response.statusCode == 200) {
        postdata.value = Post.fromJson(jsonDecode(response.body));
        postdata.refresh();
      } else {
        getDisplayAlert("Alert", "Something went wrong");
      }
    } catch (e) {
      getDisplayAlert("Alert", "Something went wrong");
    }
  }
}

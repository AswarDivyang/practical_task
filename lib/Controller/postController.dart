import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:knovator/Configuration/app_configuration.dart';
import 'package:knovator/Model/postmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostDataController extends GetxController {
  var posts = <Post>[].obs;
  Map<int, Timer?> timers = {};

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedPosts = prefs.getString('posts');

    if (cachedPosts != null) {
      List<dynamic> jsonPosts = jsonDecode(cachedPosts);
      posts.value =
          jsonPosts.map((postJson) => Post.fromJson(postJson)).toList();
    }

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List<dynamic> jsonPosts = jsonDecode(response.body);
        posts.value =
            jsonPosts.map((postJson) => Post.fromJson(postJson)).toList();
        for (var post in posts) {
          if (post.timerDuration == 0) {
            post.timerDuration = getRandomTimer();
          }
        }
        prefs.setString(
            'posts', jsonEncode(posts.map((post) => post.toJson()).toList()));
      } else {
        getDisplayAlert("Alert", "Something went wrong");
      }
    } catch (e) {
      getDisplayAlert("Alert", "Something went wrong");
    }
  }

  void markAsRead(int postId) {
    posts.firstWhere((post) => post.id == postId).isRead = true;
    posts.refresh();
  }

  int getRandomTimer() {
    return [10, 20, 30][Random().nextInt(3)];
  }

  void startTimer(int postId) {
    if (!timers.containsKey(postId) || timers[postId] == null) {
      Post post = posts.firstWhere((post) => post.id == postId);
      if (post.timerDuration > 0) {
        timers[postId] = Timer.periodic(const Duration(seconds: 1), (timer) {
          post.timerDuration--;
          if (post.timerDuration <= 0) {
            timer.cancel();
            timers[postId] = null;
          }
          posts.refresh();
        });
      }
    }
  }

  void stopTimer(int postId) {
    timers[postId]?.cancel();
    timers[postId] = null;
  }
}

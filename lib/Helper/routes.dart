import 'package:get/get.dart';
import 'package:knovator/Controller/postController.dart';
import 'package:knovator/Controller/post_details_controller.dart';
import 'package:knovator/View/Post_details.dart';

import 'package:knovator/View/post.dart';

class Routes {
  static const String postPage = '/post';
  static const String postDetails = '/postDetails';

  static List<GetPage<dynamic>> get getPages {
    return [
      GetPage(
        name: Routes.postPage,
        page: () => const PostListScreen(),
        binding: BindingsBuilder.put(
          () => PostDataController(),
        ),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: Routes.postDetails,
        page: () => const PostDetails(),
        binding: BindingsBuilder.put(
          () => PostDetailController(),
        ),
        transition: Transition.cupertino,
      ),
    ];
  }
}

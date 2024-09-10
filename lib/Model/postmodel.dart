class Post {
  int userId = 0;
  int id = 0;
  String? title;
  String? body;
  bool isRead = false;
  int timerDuration = 0;

  Post({
    this.userId = 0,
    this.id = 0,
    this.title,
    this.body,
    this.isRead = false,
    this.timerDuration = 0,
  });

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}

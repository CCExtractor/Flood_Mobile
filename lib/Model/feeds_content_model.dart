class FeedsContentsModel {
  late String? title;
  late List<dynamic> urls;

  FeedsContentsModel({
    required this.title,
    required this.urls,
  });

  factory FeedsContentsModel.fromJson(Map<String, dynamic> json) {
    return FeedsContentsModel(
      title: json['title'],
      urls: json['urls'],
    );
  }
}

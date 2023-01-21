class CurrentUserDetailModel {
  String username;
  int level;

  CurrentUserDetailModel({
    required this.username,
    required this.level,
  });

  factory CurrentUserDetailModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserDetailModel(
      username: json['username'],
      level: json['level'],
    );
  }
}

class CurrentUserDetailModel {
  String username;
  int level;

  CurrentUserDetailModel({this.username, this.level});

  CurrentUserDetailModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    level = json['level'];
  }
}

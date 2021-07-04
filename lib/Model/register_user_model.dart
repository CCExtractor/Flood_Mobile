class RegisterUserModel {
  String username;
  String password;
  String client;
  String type;
  int version;
  String url;
  String clientUsername;
  String clientPassword;
  int level;

  RegisterUserModel(
      {this.username,
      this.level,
      this.client,
      this.clientPassword,
      this.clientUsername,
      this.password,
      this.type,
      this.url,
      this.version});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'client': {
          'client': client,
          'type': type,
          'version': version,
          'url': url,
          'username': clientUsername,
          'password': clientPassword,
        },
        'level': level
      };
}

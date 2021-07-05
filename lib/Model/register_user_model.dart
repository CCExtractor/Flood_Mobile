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
  String path;
  String host;
  int port;

  RegisterUserModel(
      {this.username,
      this.level,
      this.client,
      this.clientPassword,
      this.clientUsername,
      this.password,
      this.type,
      this.url,
      this.version,
      this.path,
      this.host,
      this.port});

  Map<String, dynamic> toJson() {
    if (client == 'rTorrent' && type == 'socket') {
      return {
        'username': username,
        'password': password,
        'client': {
          'client': client,
          'type': type,
          'version': version,
          'socket': path
        },
        'level': level
      };
    } else if (client == 'rTorrent' && type == 'tcp') {
      return {
        'username': username,
        'password': password,
        'client': {
          'client': client,
          'type': type,
          'version': version,
          'host': host,
          'port': port
        },
        'level': level
      };
    }
    return {
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
}

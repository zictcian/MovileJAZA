class User {
  String username;
  String token;
  dynamic userid;

  User({this.username, this.token, this.userid});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['name'] as String,
      token: json['token'] as String,
      userid: json['user_id'] as int
    );
  }
}

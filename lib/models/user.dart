class User {
  String fullName;
  String email;
  String token;

  User({this.fullName, this.email});

  User.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        email = json['email'],
        token = json['token'];
}

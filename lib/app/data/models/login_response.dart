class LoginResponse {
  final double expiresIn;
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.expiresIn,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      expiresIn: json['expires_in']?.toDouble() ?? 0.0,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expires_in': expiresIn,
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  final String email;
  final String id;
  final String name;
  final String username;

  User({
    required this.email,
    required this.id,
    required this.name,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'id': id, 'name': name, 'username': username};
  }
}

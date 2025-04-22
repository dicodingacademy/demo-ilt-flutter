import 'dart:convert';

class UsersResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<User> data;
  UsersResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UsersResponse.fromMap(Map<String, dynamic> map) {
    return UsersResponse(
      page: map['page'].toInt() as int,
      perPage: map['per_page'].toInt() as int,
      total: map['total'].toInt() as int,
      totalPages: map['total_pages'].toInt() as int,
      data: List<User>.from(
        (map['data'] as List<dynamic>).map<User>(
          (x) => User.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory UsersResponse.fromJson(String source) =>
      UsersResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toInt() as int,
      email: map['email'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      avatar: map['avatar'] as String,
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

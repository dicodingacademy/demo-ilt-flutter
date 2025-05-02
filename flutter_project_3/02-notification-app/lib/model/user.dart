import 'dart:convert';

class User {
    int? userId;
    int? id;
    String? title;
    String? body;

    User({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// TODO: create a class called [User] using JsonSerializable
// only use the @JsonSerializable annotation, not @freezed
// because the class is not a data class.
// We use this class to map the json to the object
// and vice versa
@JsonSerializable()
class User extends Equatable {
  final String email;
  final String password;

  const User({required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [email, password];
}

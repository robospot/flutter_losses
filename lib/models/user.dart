import 'package:equatable/equatable.dart';

class User extends Equatable {
  User(
      {this.name,
      this.surname,
      this.uid,
      this.phone,
      this.email,
      this.creationDate})
      : super();

  String name;
  String surname;
  String email;
  String phone;
  String uid;
  DateTime creationDate;

  @override
  List<Object> get props => [];
}

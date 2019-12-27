import 'package:equatable/equatable.dart';

class User extends Equatable {
  User(
      {this.name,
      this.surname,
      this.uid,
      this.phone,
      this.email,
      this.creationTime})
      : super();

 final String name;
 final String surname;
 final String email;
 final String phone;
 final String uid;
 final DateTime creationTime;

  @override
  List<Object> get props => [];
}

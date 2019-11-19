import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final String phoneNumber;

  const Authenticated(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() => 'Authenticated { phoneNumber: $phoneNumber }';
}

class Unauthenticated extends AuthState {}

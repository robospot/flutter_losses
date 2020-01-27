import 'package:equatable/equatable.dart';
import 'package:flutter_losses/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { user: $user }';
}

class Unauthenticated extends AuthState {}

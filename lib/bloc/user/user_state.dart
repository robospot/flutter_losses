import 'package:equatable/equatable.dart';
import 'package:flutter_losses/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class InitialUserState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded({this.user}) : super();
  @override
  List<Object> get props => [];
}

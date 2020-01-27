import 'package:equatable/equatable.dart';
import 'package:flutter_losses/models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserProfile extends UserEvent {
  GetUserProfile() : super();
  @override
  List<Object> get props => [];
}

class UpdateUserProfile extends UserEvent {
  final User user;
  const UpdateUserProfile({this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UpdateUserProfile { user :$user }';
}

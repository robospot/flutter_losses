import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_losses/helpers/firebase_db.dart';
import 'package:flutter_losses/helpers/user_repository.dart';
import 'package:flutter_losses/models/user.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserProfile) {
      yield UserLoading();
      final User user = await UserRepository().getUser();
    
      yield UserLoaded(user: user);
    }
    if (event is UpdateUserProfile) {
      FirebaseService db = FirebaseService();
      db.updateUserProfile(event.user);
      User currentUser =
          User.fromFirestore(await db.getUserProfile(event.user.uid));

      yield UserLoaded(user: currentUser);
    }
  }
}

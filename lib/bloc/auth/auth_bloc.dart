import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_losses/utils/user_repository.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      try {
        final isSignedIn = await _userRepository.isSignedIn();
        if (isSignedIn) {
          final user = await _userRepository.getUser();
          yield Authenticated(user);
        } else {
          yield Unauthenticated();
        }
      } catch (_) {
        yield Unauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield Authenticated(await _userRepository.getUser());
    }
    if (event is LoggedOut) {
      yield Unauthenticated();
      _userRepository.signOut();
    }
  }
}

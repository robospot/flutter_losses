import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/auth/bloc.dart';
import 'helpers/user_repository.dart';

void main() {
  final UserRepository userRepository = UserRepository();
   runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (BuildContext context) => AuthBloc(userRepository: userRepository)..add(AppStarted()),
        )
      ],
      child: App(),
    ));
}
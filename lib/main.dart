import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/auth/bloc.dart';
import 'helpers/user_repository.dart';
import 'simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';


void main() {
   WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
   BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        builder: (BuildContext context) =>
            AuthBloc(userRepository: userRepository)..add(AppStarted()),
      )
    ],
    child: App(userRepository: userRepository),
  ));
}

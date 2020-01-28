import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/login/login_bloc.dart';
import 'package:flutter_losses/screens/itemListScreen/bloc/itemlist_bloc.dart';
import 'app.dart';
import 'bloc/auth/bloc.dart';
import 'bloc/user/bloc.dart';
import 'utils/user_repository.dart';
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
      ),
      BlocProvider<LoginBloc>(
          builder: (BuildContext context) =>
              LoginBloc(userRepository: userRepository)),
      BlocProvider<UserBloc>(builder: (BuildContext context) => UserBloc()),
      BlocProvider<ItemlistBloc>(
          builder: (BuildContext context) => ItemlistBloc(context)),
    ],
    child: App(userRepository: userRepository),
  ));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/login/login_bloc.dart';
import 'package:flutter_losses/screens/itemDetails/bloc/itemdetails_bloc.dart';
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
        create: (BuildContext context) =>
            AuthBloc(userRepository: userRepository)..add(AppStarted()),
      ),
      BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(userRepository: userRepository)),
      BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc()),
      BlocProvider<ItemlistBloc>(
          create: (BuildContext context) => ItemlistBloc(context: context)),
      BlocProvider<ItemdetailsBloc>(
          create: (BuildContext context) => ItemdetailsBloc()),
    ],
    child: App(userRepository: userRepository),
  ));
}

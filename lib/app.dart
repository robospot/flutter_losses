import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/bloc.dart';
import 'helpers/user_repository.dart';
import 'screens/home_screen.dart';

import 'screens/login/onboarding_screen.dart';
import 'screens/login/phone_auth_screen.dart';

import 'screens/login/sign_with_phone.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Losses',
        initialRoute: '/',
        routes: {
          '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Uninitialized) {
                    return SplashScreen();
                  }
                  if (state is Unauthenticated) {
                    //     return LoginScreen(userRepository: _userRepository);
                    return PhoneAuth(userRepository: _userRepository);
                  }
                  if (state is Authenticated) {
                    return Home();
                  }
                  return SplashScreen();
                },
              ),
          '/onboarding': (context) => Onboarding(),
          '/signWithPhone': (context) => SignWithPhone(),

          //    '/phone_auth': (context) => PhoneAuth(),
        });
  }
}

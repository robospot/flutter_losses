import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'bloc/auth/bloc.dart';
import 'helpers/user_repository.dart';
import 'screens/login/onboarding_screen.dart';
import 'screens/login/phone_auth_screen.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Losses',
        initialRoute: '/',
        routes: {
          '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Unauthenticated) {
                    return Onboarding();
                  }
                  if (state is Authenticated) {
                    return Onboarding();
                  }
                  return SplashScreen();
                },
              ),
          '/onboarding': (context) => Onboarding(),
          '/phone_auth': (context) => PhoneAuth(),
        });
  }
}

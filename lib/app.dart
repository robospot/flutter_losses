import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/bloc.dart';
import 'utils/user_repository.dart';
import 'screens/home_screen.dart';

import 'screens/login/login_screen.dart';
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
        theme: ThemeData(
           primarySwatch: Colors.blue,
          backgroundColor: Color.lerp(Colors.grey[200], Colors.black, 0.005),
          scaffoldBackgroundColor: Colors.grey[200],
          dialogBackgroundColor: Colors.grey[300],
            // buttonTheme: ButtonThemeData(
            //     buttonColor: Color(0xFFFF7F5D),
            //     textTheme: ButtonTextTheme.accent, ),
                accentColor: Colors.white
                ),
                 home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        if (state is Unauthenticated) {
          return LoginScreen(userRepository: _userRepository);
        }

        if (state is Authenticated) {
          return HomeScreen();
        }
      
        return Container();
      }),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => BlocBuilder<AuthBloc, AuthState>(
        //         builder: (context, state) {
        //           if (state is Uninitialized) {
        //             return SplashScreen();
        //           }
        //           if (state is Unauthenticated) {
        //             //     return LoginScreen(userRepository: _userRepository);
        //             return Onboarding();
        //             //PhoneAuth(userRepository: _userRepository);
        //           }
        //           if (state is Authenticated) {
        //             return Home();
        //           }
        //           return SplashScreen();
        //         },
        //       ),
        //   '/onboarding': (context) => Onboarding(),
        //   '/signWithPhone': (context) => BlocBuilder<AuthBloc, AuthState>(
        //         builder: (context, state) {
        //           if (state is Uninitialized) {
        //             return SplashScreen();
        //           }
        //           if (state is Unauthenticated) {
        //             //     return LoginScreen(userRepository: _userRepository);
        //             return SignWithPhone();
        //           }
        //           if (state is Authenticated) {
        //             return Home();
        //           }
        //           return SplashScreen();
        //         },
        //       ),
        //   '/phone_auth': (context) =>
        //       PhoneAuth(userRepository: _userRepository),
        // }
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/bloc.dart';
import 'models/item.dart';
import 'screens/add_object.dart';
import 'screens/itemDetails/itemDetailsScreen.dart';
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
            // backgroundColor: Color.lerp(Color(0xffEBF3FA), Color(0xffE5F0F9), 0.005), Color(0xFFF1F3F6)
            // scaffoldBackgroundColor: Color.lerp(Color(0xffEBF3FA), Color(0xffE5F0F9), 0.005),
            scaffoldBackgroundColor: Color(0xFFF1F3F6),
            dialogBackgroundColor: Colors.grey[300],
            appBarTheme: AppBarTheme(
              color: Color(0xFFF1F3F6),
              elevation: 0,
            ),
            // buttonTheme: ButtonThemeData(
            //     buttonColor: Color(0xFFFF7F5D),
            //     textTheme: ButtonTextTheme.accent, ),
            //primaryTextTheme: TextTheme(subtitle: )
            primaryTextTheme: TextTheme(
                headline6: TextStyle(
                    color: Color(0xFF4D70A6),
                    fontSize: 26,
                    fontWeight: FontWeight.bold)),
            primaryIconTheme: IconThemeData(color: Colors.blueGrey[500])),
        //            home: BlocBuilder<AuthBloc, AuthState>(
        //     builder: (context, state) {
        //   if (state is Uninitialized) {
        //     return SplashScreen();
        //   }
        //   if (state is Unauthenticated) {
        //     return LoginScreen(userRepository: _userRepository);
        //   }

        //   if (state is Authenticated) {
        //     return HomeScreen();
        //   }

        //   return Container();
        // }),
        initialRoute: '/',
        routes: {
          '/': (context) =>
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
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
          '/itemDetails': (context) {
            Item item = ModalRoute.of(context).settings.arguments;
            return ItemDetailsScreen(
              item: item,
            );
          },
          '/addItem': (context) => AddObjectScreen()
        }
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

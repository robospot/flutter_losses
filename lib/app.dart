import 'package:flutter/material.dart';
import 'package:flutter_losses/screens/login/phone_auth.dart';

import 'screens/login/onboarding_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Losses',
       initialRoute: '/',
       routes: {
        '/': (context) => Onboarding(),
        '/onboarding' :  (context) => Onboarding(),
        '/phone_auth' :   (context) => PhoneAuth(),
       }
    );
  }
}
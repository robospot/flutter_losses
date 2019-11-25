import 'package:flutter/material.dart';
import 'package:flutter_losses/widgets/buttons.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        )),
// Image.asset('assets/background.png', fit: BoxFit.fill,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Image.asset(
                'assets/losses.png',
              ),
            ),
            MainButton(
                caption: "Войти",
                onPressed: () => Navigator.of(context).pushNamed('/phone_auth'))
          ],
        )
      ],
    );
  }
}

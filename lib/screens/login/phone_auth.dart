import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  PhoneAuth({Key key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
        Column(children: <Widget>[
Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage(
                "assets/background2.png",
                
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        // Image.asset(
        //   'assets/background2.png',
        //   fit: BoxFit.fitWidth
        // ),
        Text("Losses", style: TextStyle(fontSize: 60),),
        
      ],
      
    ),
    TextField(),
    
        ],)
        );
  }
}

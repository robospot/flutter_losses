import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;


class PhoneAuth extends StatefulWidget {
  PhoneAuth({Key key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId;

  @override
  Widget build(BuildContext context) {
    print("!!!!!!!");
    _auth.currentUser().then((onValue) => print(onValue.phoneNumber));
  
 
    return   Scaffold(
        body: SingleChildScrollView(child: Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 250,
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
            Text(
              "Losses",
              style: TextStyle(fontSize: 60),
            ),
          ],
        ),
        //Кусок Google авторизации
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: const Text('Test sign in with phone number'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                  labelText: 'Phone number (+x xxx-xxx-xxxx)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Phone number (+x xxx-xxx-xxxx)';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  _verifyPhoneNumber();
                },
                child: const Text('Verify phone number'),
              ),
            ),
            TextField(
              controller: _smsController,
              decoration: const InputDecoration(labelText: 'Verification code'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  _signInWithPhoneNumber();
                },
                child: const Text('Sign in with phone number'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _message,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        )
      ],
    )));
  }

  // Example code of how to verify phone number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      // Scaffold.of(context).showSnackBar(const SnackBar(
      //   content: Text('Please check your phone for the verification code.'),
      // )
   //   );
   print("****Please check your phone for the verification code****");
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }
    });
  }
}

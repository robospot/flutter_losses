import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/login/bloc.dart';

import 'package:flutter_losses/widgets/buttons.dart';

import '../../bloc/auth/bloc.dart';
import '../../helpers/user_repository.dart';

class PhoneAuth extends StatefulWidget {
  final UserRepository _userRepository;
  PhoneAuth({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _phoneController = TextEditingController();
  //final TextEditingController _smsController = TextEditingController();
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated => _phoneController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: ListView(
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
                    Text(
                      "Losses",
                      style: TextStyle(fontSize: 60),
                    ),
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Phone',
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPhoneValid ? 'Invalid Phone' : null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      MainButton(
                        caption: "Войти",
                        onPressed: isLoginButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }

  // @override
  // Widget build(BuildContext context) {

  //   return   Scaffold(
  //       body: BlocProvider<LoginBloc>(
  //       builder: (context) => LoginBloc(userRepository: widget._userRepository),
  //       child:

  //     SingleChildScrollView(child: Column(
  //     children: <Widget>[
  //       Stack(
  //         alignment: Alignment.bottomCenter,
  //         children: <Widget>[
  //           Container(
  //             height: 250,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 alignment: Alignment.topCenter,
  //                 image: AssetImage(
  //                   "assets/background2.png",
  //                 ),
  //                 fit: BoxFit.fill,
  //               ),
  //             ),
  //           ),
  //           // Image.asset(
  //           //   'assets/background2.png',
  //           //   fit: BoxFit.fitWidth
  //           // ),
  //           Text(
  //             "Losses",
  //             style: TextStyle(fontSize: 60),
  //           ),
  //         ],
  //       ),
  //       //Кусок Google авторизации
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           // Container(
  //           //   child: const Text('Test sign in with phone number'),
  //           //   padding: const EdgeInsets.all(16),
  //           //   alignment: Alignment.center,
  //           // ),
  //           TextFormField(
  //             controller: _phoneNumberController,
  //             decoration: const InputDecoration(
  //                 labelText: 'Phone number (+x xxx-xxx-xxxx)'),
  //             validator: (String value) {
  //               if (value.isEmpty) {
  //                 return 'Phone number (+x xxx-xxx-xxxx)';
  //               }
  //               return null;
  //             },
  //           ),
  //           Container(
  //             padding: const EdgeInsets.symmetric(vertical: 16.0),
  //             alignment: Alignment.center,
  //             child: RaisedButton(
  //               onPressed: () async {
  //                 _verifyPhoneNumber();
  //               },
  //               child: const Text('Verify phone number'),
  //             ),
  //           ),
  //           TextField(
  //             controller: _smsController,
  //             decoration: const InputDecoration(labelText: 'Verification code'),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.symmetric(vertical: 16.0),
  //             alignment: Alignment.center,
  //             child: RaisedButton(
  //               onPressed: () async {
  //                 _signInWithPhoneNumber();
  //               },
  //               child: const Text('Sign in with phone number'),
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             child: Text(
  //               _message,
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           )
  //         ],
  //       )
  //     ],
  //   )
  //   )
  //   )
  //   );
  // }

  void _onPhoneChanged() {
    _loginBloc.add(
      PhoneChanged(phone: _phoneController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      VerifyPhoneNumber(phone: _phoneController.text),
    );
    Navigator.of(context)
        .pushNamed('/signWithPhone', arguments: widget._userRepository);
    //Navigator.of(context).pushNamed();
  }

  // Example code of how to verify phone number
  // void _verifyPhoneNumber() async {
  //   setState(() {
  //     _message = '';
  //   });
  //   final PhoneVerificationCompleted verificationCompleted =
  //       (AuthCredential phoneAuthCredential) {
  //     _auth.signInWithCredential(phoneAuthCredential);
  //     setState(() {
  //       _message = 'Received phone auth credential: $phoneAuthCredential';
  //     });
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     setState(() {
  //       _message =
  //           'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
  //     });
  //   };

  //   final PhoneCodeSent codeSent =
  //       (String verificationId, [int forceResendingToken]) async {
  //     // Scaffold.of(context).showSnackBar(const SnackBar(
  //     //   content: Text('Please check your phone for the verification code.'),
  //     // )
  //  //   );
  //  print("****Please check your phone for the verification code****");
  //     _verificationId = verificationId;
  //   };

  //   final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationId) {
  //     _verificationId = verificationId;
  //   };

  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: _phoneNumberController.text,
  //       timeout: const Duration(seconds: 5),
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  // }

  // Example code of how to sign in with phone.
  // void _signInWithPhoneNumber() async {
  //   final AuthCredential credential = PhoneAuthProvider.getCredential(
  //     verificationId: _verificationId,
  //     smsCode: _smsController.text,
  //   );
  //   final FirebaseUser user =
  //       (await _auth.signInWithCredential(credential)).user;
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);
  //   setState(() {
  //     if (user != null) {
  //       _message = 'Successfully signed in, uid: ' + user.uid;
  //     } else {
  //       _message = 'Sign in failed';
  //     }
  //   });
  // }
}

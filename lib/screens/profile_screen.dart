import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/user/bloc.dart';
import 'package:flutter_losses/bloc/user/user_bloc.dart';
import 'package:flutter_losses/models/user.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  UserBloc userBloc;
  final _formKey = GlobalKey<FormState>();
  User user = User();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(GetUserProfile());

  }

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    // userName.addListener(_onUserChanged);
    // email.addListener(_onEmailChanged);
    // phone.addListener(_onPhoneChanged)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(16),
            child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              if ((state is InitialUserState) || (state is UserLoading)) {
                return CircularProgressIndicator();
              }
              if (state is UserLoaded) {
                user = state.user;
                userNameController.text = state.user.displayName;
                emailController.text = state.user.email ?? "";
                phoneController.text = state.user.phone ?? "";
                return Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(labelText: "Имя"),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(labelText: "email"),
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(labelText: "Телефон"),
                        ),
                        RaisedButton(
                          onPressed: () => onFormSubmitted(state.user),
                          child: Text('Обновить'),
                        )
                      ],
                    ));
              }
              return Container();
            })));
  }

  onFormSubmitted(User currentUser) {
    if (_formKey.currentState.validate()) {
      user = User(displayName: userNameController.text, email: emailController.text, phone: phoneController.text, uid: currentUser.uid);
      userBloc.add(UpdateUserProfile(user: user));
    //   Scaffold.of(context)
    //       .showSnackBar(SnackBar(content: Text('Processing Data')));
    // }
  }
  //  void _onUserChanged() {
  //   userBloc.add(
  //     UserChanged(user: userName.text),
  //   );
  // }
}
}
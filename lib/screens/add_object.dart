import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/auth/bloc.dart';
import 'package:flutter_losses/helpers/user_repository.dart';

class AddObjectScreen extends StatefulWidget {
  AddObjectScreen({Key key}) : super(key: key);

  @override
  _AddObjectScreenState createState() => _AddObjectScreenState();
}

class ObjectData {
  String name = '';
  String description = '';
  String objectId = '';
  String userId = '';
}

class _AddObjectScreenState extends State<AddObjectScreen> {
  ObjectData objectData = ObjectData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            //  SingleChildScrollView(
            //     child:
            Container(
                child: Form(key: _formKey,
                    child: ListView(
      children: <Widget>[
        TextFormField(
            decoration: new InputDecoration(
                hintText: 'название', labelText: 'Название'),
            //validator: this._validatePassword,
            onSaved: (String value) {
              objectData.name = value;
              //   this._data.password = value;
            }),
        TextFormField(
            decoration: new InputDecoration(
                hintText: 'Описание', labelText: 'Описание'),
            //validator: this._validatePassword,
            onSaved: (String value) {
              objectData.description = value;
              //   this._data.password = value;
            }),
        RaisedButton(
          child: Text("Создать"),
          onPressed: () => createObject(objectData, _formKey, context),
        ),
        RaisedButton(
          child: Text("Выход"),
          onPressed: () => BlocProvider.of<AuthBloc>(context).add(LoggedOut()),
        )
      ],
    )))
        // )
        );
  }
}

createObject(ObjectData objectData, GlobalKey<FormState> _formkey, BuildContext context) {
   UserRepository _userRepository = UserRepository();
  _formkey.currentState.save();
  var rng = new Random();
  objectData.objectId = rng.nextInt(10000).toString();
  objectData.userId = ((BlocProvider.of<AuthBloc>(context).state) as Authenticated).user.uid;
  _userRepository.addObject(objectData);
  var documentReference = Firestore.instance
      .collection('objects')
      // .document()
      // .collection('objects')
      .document(objectData.objectId);
  //.document(DateTime.now().millisecondsSinceEpoch.toString());

  Firestore.instance.runTransaction((transaction) async {
    await transaction.set(
      documentReference,
      {
        'objectid': objectData.objectId,
        'name': objectData.name,
        'description': objectData.description,
        'userid': objectData.userId
      },
    );
  });
}

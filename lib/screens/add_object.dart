import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/auth/bloc.dart';
import 'package:flutter_losses/helpers/firebase_db.dart';
import 'package:flutter_losses/models/item.dart';


class AddObjectScreen extends StatefulWidget {
  AddObjectScreen({Key key}) : super(key: key);

  @override
  _AddObjectScreenState createState() => _AddObjectScreenState();
}

// class ObjectData {
//   String name = '';
//   String description = '';
//   String objectId = '';
//   String userId = '';
// }

class _AddObjectScreenState extends State<AddObjectScreen> {
  Item item = Item();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            //  SingleChildScrollView(
            //     child:
            Container(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(controller: nameController,
                          decoration: new InputDecoration(
                              hintText: 'название', labelText: 'Название'),
                          //validator: this._validatePassword,
                          // onSaved: (String value) {
                          //   entity.entityName = value;
                          //   //   this._data.password = value;
                          // }
                        ),
                        TextFormField(controller: descriptionController,
                          decoration: new InputDecoration(
                              hintText: 'Описание', labelText: 'Описание'),
                          //validator: this._validatePassword,
                          // onSaved: (String value) {
                          //   objectData.description = value;
                          //   //   this._data.password = value;
                          // }
                        ),
                        RaisedButton(
                          child: Text("Создать"),
                          onPressed: () => createObject(_formKey, context),
                        ),
                        RaisedButton(
                          child: Text("Выход"),
                          onPressed: () => BlocProvider.of<AuthBloc>(context)
                              .add(LoggedOut()),
                        )
                      ],
                    )))
        // )
        );
  }

  createObject(GlobalKey<FormState> _formKey, BuildContext context) {
    // UserRepository _userRepository = UserRepository();
    // _formkey.currentState.save();
    if (_formKey.currentState.validate()) {
      FirebaseService db = FirebaseService();

      var rng = new Random();
      Item item = Item(
          itemId: rng.nextInt(10000).toString(),
          userId: ((BlocProvider.of<AuthBloc>(context).state) as Authenticated)
              .user
              .uid,
          itemName: nameController.text,
          itemDescription: descriptionController.text);
      db.createItem(item);
    }

    // _userRepository.addObject(objectData);
    // var documentReference = Firestore.instance
    //     .collection('objects')
    //     // .document()
    //     // .collection('objects')
    //     .document(objectData.objectId);
    // //.document(DateTime.now().millisecondsSinceEpoch.toString());

    // Firestore.instance.runTransaction((transaction) async {
    //   await transaction.set(
    //     documentReference,
    //     {
    //       'objectid': objectData.objectId,
    //       'name': objectData.name,
    //       'description': objectData.description,
    //       'userid': objectData.userId
    //     },
    //   );
    // });
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddObjectScreen extends StatefulWidget {
  AddObjectScreen({Key key}) : super(key: key);

  @override
  _AddObjectScreenState createState() => _AddObjectScreenState();
}


class ObjectData {
  String name = '';
  String description = '';
  String id ='';
}

class _AddObjectScreenState extends State<AddObjectScreen> {
  ObjectData objectData = ObjectData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        //  SingleChildScrollView(
        //     child:
             Container(
                child: Form(
                    child: ListView(
      children: <Widget>[
        TextFormField(
          decoration:
              new InputDecoration(hintText: 'название', labelText: 'Название'),
          //validator: this._validatePassword,
           onSaved: (String value) {
          objectData.name = value;
          //   this._data.password = value;
          }
        ),
        TextFormField(
          decoration:
              new InputDecoration(hintText: 'Описание', labelText: 'Описание'),
          //validator: this._validatePassword,
          onSaved: (String value) {
            objectData.description = value;
          //   this._data.password = value;
          }
        ),
        RaisedButton(child: Text("Создать"), onPressed: () => createObject(objectData),)
              ],
            )))
            // )
            );
          }
        }
        
        createObject(ObjectData objectData) {
           var rng = new Random();
           objectData.id = rng.nextInt(10000).toString();
           
           var documentReference = Firestore.instance
          .collection('Users')
          .document()
          .collection('objects')
          .document(objectData.name);
          //.document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'id': objectData.id,
            'name': objectData.name,
            'description': objectData.description
            // 'idFrom': id,
            // 'idTo': peerId,
            // 'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            // 'content': content,
            // 'type': type
          },
        );
      });
}

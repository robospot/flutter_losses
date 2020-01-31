import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ObjectListScreen extends StatefulWidget {
  ObjectListScreen({Key key}) : super(key: key);

  @override
  _ObjectListScreenState createState() => _ObjectListScreenState();
}

class _ObjectListScreenState extends State<ObjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        future: getData(),
        //initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => ListTile(
                leading: Text(snapshot.data.documents[index].data['id']),
                    title: Text(snapshot.data.documents[index].data['name']),
                    subtitle: Text(snapshot.data.documents[index].data['description']),
                  ));
        },
      ),
    );
  }

  Future<QuerySnapshot> getData() async {
    var documentReference = Firestore.instance;
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    var objectList = documentReference
        .collection("users")
        .document(currentUser.phoneNumber)
        .collection('objects')
        .getDocuments();
        return objectList;
  }
}

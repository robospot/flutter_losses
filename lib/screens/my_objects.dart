import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/auth/bloc.dart';
import 'package:flutter_losses/helpers/firebase_db.dart';
import 'package:flutter_losses/models/item.dart';
import 'package:flutter_losses/screens/object_details.dart';

class MyObjects extends StatefulWidget {
  MyObjects({Key key}) : super(key: key);

  @override
  _MyObjectsState createState() => _MyObjectsState();
}

class _MyObjectsState extends State<MyObjects> {

  FirebaseService db = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<DocumentSnapshot>>(
        future: db.getItems(
            ((BlocProvider.of<AuthBloc>(context).state) as Authenticated).user),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Item> items = snapshot.data.map((s) => Item.fromFirestore(s)).toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetailScreen(item: items[index],)),
                  ),
                  title: Text(items[index].itemId),
                  subtitle: Text(items[index].itemDescription),
                );
              },
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

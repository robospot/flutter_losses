import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/auth/bloc.dart';
import 'package:flutter_losses/helpers/user_repository.dart';
import 'package:flutter_losses/screens/object_details.dart';

class MyObjects extends StatefulWidget {
  MyObjects({Key key}) : super(key: key);

  @override
  _MyObjectsState createState() => _MyObjectsState();
}

class _MyObjectsState extends State<MyObjects> {
  UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<DocumentSnapshot>>(
        future: _userRepository.listObjects(
            ((BlocProvider.of<AuthBloc>(context).state) as Authenticated).user),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ObjectDetails(object: snapshot.data[index],)),
                  ),
                  title: Text(snapshot.data[index]['name']),
                  subtitle: Text(snapshot.data[index]['description']),
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

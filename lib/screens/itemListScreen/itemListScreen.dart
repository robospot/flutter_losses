import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/screens/itemListScreen/bloc/itemlist_bloc.dart';

class itemListScreen extends StatefulWidget {
  itemListScreen({Key key}) : super(key: key);

  @override
  _itemListScreenState createState() => _itemListScreenState();
}

class _itemListScreenState extends State<itemListScreen> {
  ItemlistBloc itemListBloc;
  
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    itemListBloc = BlocProvider.of<ItemlistBloc>(context);
    itemListBloc.add(GetitemList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: child,
    );
  }
}
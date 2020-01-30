import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/screens/itemListScreen/bloc/itemlist_bloc.dart';

class ItemListScreen extends StatefulWidget {
  ItemListScreen({Key key}) : super(key: key);

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  ItemlistBloc itemListBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    itemListBloc = BlocProvider.of<ItemlistBloc>(context);
    itemListBloc.add(GetitemList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Мои вещи"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () => addItem(),)
          ],
        ),
        body: Container(child:
            BlocBuilder<ItemlistBloc, ItemlistState>(builder: (context, state) {
          if ((state is ItemListInitial) || (state is ItemListLoading)) {
            return CircularProgressIndicator();
          }
          if (state is ItemListLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => Navigator.pushNamed(context, '/itemDetails',
                      arguments: state.items[index]),
                  title: Text(state.items[index].itemName),
                  subtitle: Text(state.items[index].itemDescription),
                );
              },
            );
          }
          return Container();
        })));
  }
  addItem(){
    Navigator.of(context).pushNamed('/addItem');
  }
}

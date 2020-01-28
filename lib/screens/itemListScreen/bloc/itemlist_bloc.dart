import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_losses/bloc/auth/bloc.dart';
import 'package:flutter_losses/models/item.dart';
import 'package:flutter_losses/models/user.dart';
import 'package:flutter_losses/utils/firebase_db.dart';

part 'itemlist_event.dart';
part 'itemlist_state.dart';

class ItemlistBloc extends Bloc<ItemlistEvent, ItemlistState> {
  ItemlistBloc({this.context});
  final BuildContext context;
  @override
  ItemlistState get initialState => ItemListInitial();

  @override
  Stream<ItemlistState> mapEventToState(
    ItemlistEvent event,
  ) async* {
    if (event is GetitemList) {
      yield ItemListLoading();
      final User user =
          ((BlocProvider.of<AuthBloc>(context).state) as Authenticated).user;
      List<Item> items = await FirebaseService().getItems(user);
      yield ItemListLoaded(items: items);
    }
  }
}

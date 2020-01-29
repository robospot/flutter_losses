import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_losses/models/item.dart';
import 'package:flutter_losses/utils/firebase_db.dart';

part 'itemdetails_event.dart';
part 'itemdetails_state.dart';

class ItemdetailsBloc extends Bloc<ItemdetailsEvent, ItemdetailsState> {
  @override
  ItemdetailsState get initialState => ItemDetailsInitial();

  @override
  Stream<ItemdetailsState> mapEventToState(
    ItemdetailsEvent event,
  ) async* {
    if (event is GetItemDetails) {
      yield ItemDetailsLoading();
      Item item = event.item;
      yield ItemDetailsLoaded(isEditing: false, item: item);
    }
    if (event is ChangeItemDetails) {
      yield ItemDetailsLoading();
      Item item = event.item;
      yield ItemDetailsLoaded(isEditing: event.isEditing, item: item);
    }

    if (event is UpdateItemDetails) {
      yield ItemDetailsLoading();
      Item item = event.item;
      // Item(
      //     itemDescription: event.itemDescription,
      //     itemId: event.itemId,
      //     itemName: event.itemName,
      //     showEmail: event.showEmail,
      //     showPhone: event.showPhone,
      //     userId: event.userId);
      yield ItemDetailsLoaded(isEditing: true, item: item);
    }

    if (event is SaveItemDetails) {
      yield ItemDetailsLoading();
      Item item = event.item;
      FirebaseService().updateItem(item);
      yield ItemDetailsLoaded(isEditing: false, item: item);
    }
  }
}

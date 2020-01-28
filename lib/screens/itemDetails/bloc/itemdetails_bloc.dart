import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_losses/models/item.dart';

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
      yield ItemDetailsLoaded(item: item);
    }
  }
}

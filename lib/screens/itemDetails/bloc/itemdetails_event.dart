part of 'itemdetails_bloc.dart';

abstract class ItemdetailsEvent extends Equatable {
  const ItemdetailsEvent();
}

class GetItemDetails extends ItemdetailsEvent {
  final Item item;
  GetItemDetails({this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'GetItemDetails {$item}';
}

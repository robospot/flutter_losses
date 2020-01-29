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

class ChangeItemDetails extends ItemdetailsEvent {
  final bool isEditing;
  final Item item;
  ChangeItemDetails({this.item, this.isEditing});

  @override
  List<Object> get props => [item, isEditing];

  @override
  String toString() => 'ChangeItemDetails {$item}';
}

class UpdateItemDetails extends ItemdetailsEvent {
  final Item item;
  // final String itemName;
  // final String itemDescription;
  // final String itemId;
  // final String userId;
  // final bool showPhone;
  // final bool showEmail;
  // UpdateItemDetails({this.itemName, this.itemDescription, this.itemId, this.userId, this.showEmail, this.showPhone});
  UpdateItemDetails({this.item});
  @override
  List<Object> get props => [];

  @override
  String toString() => 'UpdateItemDetails {}';
}

class SaveItemDetails extends ItemdetailsEvent {
  final Item item;
  SaveItemDetails({this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'SaveItemDetails {$item}';
}

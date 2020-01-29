part of 'itemdetails_bloc.dart';

abstract class ItemdetailsState extends Equatable {
  const ItemdetailsState();
}

class ItemDetailsInitial extends ItemdetailsState {
  @override
  List<Object> get props => [];
}

class ItemDetailsLoading extends ItemdetailsState {
  ItemDetailsLoading() : super();
  @override
  List<Object> get props => [];
}

class ItemDetailsLoaded extends ItemdetailsState {
  final bool isEditing;
  final Item item;
  ItemDetailsLoaded({this.item, this.isEditing}) : super();
  @override
  List<Object> get props => [item];
}

class ItemDetailsChanging extends ItemdetailsState {
  final Item item;
  ItemDetailsChanging({this.item}) : super();
  @override
  List<Object> get props => [item];
}
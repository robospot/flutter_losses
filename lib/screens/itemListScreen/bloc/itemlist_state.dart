part of 'itemlist_bloc.dart';

abstract class ItemlistState extends Equatable {
  const ItemlistState();
}

class ItemListInitial extends ItemlistState {
  @override
  List<Object> get props => [];
}

class ItemListLoading extends ItemlistState {
  @override
  List<Object> get props => [];
}
class ItemListLoaded extends ItemlistState {
  final List<Item> items;
  ItemListLoaded({this.items}):super();
  @override
  List<Object> get props => [];
}
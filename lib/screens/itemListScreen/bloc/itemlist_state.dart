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
  @override
  List<Object> get props => [];
}
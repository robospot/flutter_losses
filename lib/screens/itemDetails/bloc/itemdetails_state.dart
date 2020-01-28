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
  final Item item;
  ItemDetailsLoaded({this.item}) : super();
  @override
  List<Object> get props => [item];
}

part of 'itemlist_bloc.dart';

abstract class ItemlistEvent extends Equatable {
  const ItemlistEvent();
}

class GetitemList extends ItemlistEvent {
  
  const GetitemList();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetitemList {}';
}

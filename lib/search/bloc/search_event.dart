part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchStarted extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchItemAdded extends SearchEvent {
  const SearchItemAdded(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class CartItemRemoved extends SearchEvent {
  const CartItemRemoved(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}


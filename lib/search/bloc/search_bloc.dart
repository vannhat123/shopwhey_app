import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../catalog/models/item.dart';
import '../../catalog/shopping_repository.dart';
import '../models/search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.shoppingRepository}) : super(SearchLoading()) {
    on<SearchStarted>(_onStarted);
    on<SearchItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
  }

  final ShoppingRepository shoppingRepository;

  void _onStarted(SearchStarted event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final items = await shoppingRepository.loadCartItems();
      emit(SearchLoaded(search: Search(items: [...items])));
    } catch (_) {
      emit(SearchError());
    }
  }

  void _onItemAdded(SearchItemAdded event, Emitter<SearchState> emit) async {
    final state = this.state;
    if (state is SearchLoaded) {
      try {
        shoppingRepository.addItemToCart(event.item);
        emit(SearchLoaded(search: Search(items: [...state.search.items, event.item])));
      } catch (_) {
        emit(SearchError());
      }
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<SearchState> emit) {
    final state = this.state;
    if (state is SearchLoaded) {
      try {
        shoppingRepository.removeItemFromCart(event.item);
        emit(
          SearchLoaded(
            search: Search(
              items: [...state.search.items]..remove(event.item),
            ),
          ),
        );
      } catch (_) {
        emit(SearchError());
      }
    }
  }
}

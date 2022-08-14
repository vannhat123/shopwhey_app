import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/catalog.dart';
import '../shopping_repository.dart';

part 'catalog_event.dart';

part 'catalog_state.dart';


class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ShoppingRepository shoppingRepository;

  CatalogBloc({required this.shoppingRepository}) : super(CatalogLoading()) {
    on<CatalogStarted>(_onStarted);
  }

  Future<void> _onStarted(
      CatalogStarted event, Emitter<CatalogState> emit) async {
    emit(CatalogLoading());
    try {
      final catalog = await shoppingRepository.loadCatalog();
      emit(CatalogLoaded(Catalog(iteamS: catalog)));
    } catch (_) {
      emit(CatalogError());
    }
  }
}

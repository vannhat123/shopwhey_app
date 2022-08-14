part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  const SearchLoaded({this.search = const Search()});

  final Search search;

  @override
  List<Object> get props => [search];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}

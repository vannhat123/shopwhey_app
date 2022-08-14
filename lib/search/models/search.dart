import 'package:equatable/equatable.dart';

import '../../catalog/models/item.dart';

class Search extends Equatable {
  const Search({this.items = const <Item>[]});

  final List<Item> items;

  double get totalPrice {
    return items.fold(0, (total, current) => (total + current.price));
  }

  @override
  List<Object> get props => [items];
}

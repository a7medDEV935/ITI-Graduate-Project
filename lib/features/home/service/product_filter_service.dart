import 'package:flutter/material.dart';
import '../data/models/product_model.dart';

enum SortBy {
  aToZ,
  zToA,
  priceDescending,
  priceAscending,
}

extension SortByExtension on SortBy {
  String get label {
    switch (this) {
      case SortBy.aToZ:
        return 'A to Z';
      case SortBy.zToA:
        return 'Z to A';
      case SortBy.priceDescending:
        return 'Price ↓';
      case SortBy.priceAscending:
        return 'Price ↑';
    }
  }
}

class ProductFilter {
  final SortBy? sortBy;

  const ProductFilter({this.sortBy});

  List<ProductModel> filterAndSort(List<ProductModel> products) {
    List<ProductModel> result = [...products];

    if (sortBy != null) {
      switch (sortBy!) {
        case SortBy.aToZ:
          result.sort((a, b) => a.title.compareTo(b.title));
          break;
        case SortBy.zToA:
          result.sort((a, b) => b.title.compareTo(a.title));
          break;
        case SortBy.priceDescending:
          result.sort((a, b) => a.price.compareTo(b.price));
          break;
        case SortBy.priceAscending:
          result.sort((a, b) => b.price.compareTo(a.price));
          break;
      }
    }
    return result;
  }
}

class ProductSortDropdown extends StatelessWidget {
  final SortBy selected;
  final ValueChanged<SortBy> onChanged;

  const ProductSortDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SortBy>(
      value: selected,
      onChanged: (SortBy? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      items: SortBy.values.map((sortOption) {
        return DropdownMenuItem<SortBy>(
          value: sortOption,
          child: Text(sortOption.label),
        );
      }).toList(),
    );
  }
}

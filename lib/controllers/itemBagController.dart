import 'package:eccomerce_riverpod_flutter/model/productModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<ProductModel> itemBag = [];

class ItemBagNotifier extends StateNotifier<List<ProductModel>> {
  ItemBagNotifier() : super(itemBag);

  // Add new item

  void addNewItemBag(ProductModel productModel) {
    state = [...state, productModel];
  }

  // Remove item

  void removeItem(int pid) {
    state = [
      for (final product in state)
        if (product.pid != pid) product,
    ];
  }
}

final itemBagProvider =
    StateNotifierProvider<ItemBagNotifier, List<ProductModel>>((ref) {
  return ItemBagNotifier();
});

final priceCalcProvider = StateProvider<double>((ref) {
  final itemBag = ref.watch(itemBagProvider);

  double sum = 0;
  for (var element in itemBag) {
    sum += element.price;
  }

  return sum;
});

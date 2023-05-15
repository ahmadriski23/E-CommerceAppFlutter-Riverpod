import 'package:eccomerce_riverpod_flutter/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:status_alert/status_alert.dart';

import '../controllers/itemBagController.dart';
import '../controllers/productController.dart';
import '../model/productModel.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({
    super.key,
    required this.productIndex,
  });

  final int productIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productNotifierProvider);

    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      margin: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(12),
              color: kLightBackground,
              child: Image.asset(product[productIndex].imgUrl),
            ),
          ),
          Gap(4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product[productIndex].title,
                  style: AppTheme.kCardTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product[productIndex].shortDescription,
                  style: AppTheme.kBodyText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product[productIndex].price}',
                      style: AppTheme.kCardTitle,
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(productNotifierProvider.notifier).isSelecItem(
                            product[productIndex].pid, productIndex);

                        // Item add to bag
                        if (product[productIndex].isSelected == false) {
                          ref.read(itemBagProvider.notifier).addNewItemBag(
                              ProductModel(
                                  pid: product[productIndex].pid,
                                  imgUrl: product[productIndex].imgUrl,
                                  title: product[productIndex].title,
                                  price: product[productIndex].price,
                                  shortDescription:
                                      product[productIndex].shortDescription,
                                  longDescription:
                                      product[productIndex].longDescription,
                                  reviews: product[productIndex].reviews,
                                  rating: product[productIndex].rating));

                          StatusAlert.show(
                            context,
                            duration: Duration(seconds: 2),
                            title: 'Add To Bag',
                            subtitle: 'Item has be added to bag',
                            configuration:
                                IconConfiguration(icon: Icons.favorite),
                            maxWidth: 300,
                          );
                        } else {
                          ref.read(itemBagProvider.notifier).removeItem(
                                product[productIndex].pid,
                              );
                          StatusAlert.show(
                            context,
                            duration: Duration(seconds: 2),
                            title: 'Remove To Bag',
                            subtitle: 'Item has be removed to bag',
                            configuration:
                                IconConfiguration(icon: Icons.delete),
                            maxWidth: 300,
                          );
                        }
                      },
                      icon: Icon(
                        product[productIndex].isSelected
                            ? Icons.check_circle
                            : Icons.add_circle,
                        size: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:eccomerce_riverpod_flutter/controllers/productController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:status_alert/status_alert.dart';

import '../constants/themes.dart';
import '../controllers/itemBagController.dart';
import '../model/productModel.dart';
import 'cartPage.dart';
import 'homePage.dart';

class DetailsPage extends ConsumerWidget {
  DetailsPage({super.key, required this.getIndex});

  int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(productNotifierProvider);
    final itemBag = ref.watch(itemBagProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        title: Text('Product Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 10),
            child: Badge(
                label: Text(itemBag.length.toString()),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.local_mall, size: 24))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: kLightBackground,
              child: Image.asset(product[getIndex].imgUrl),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product[getIndex].title,
                    style: AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                  ),
                  Gap(12),
                  Row(
                    children: [
                      RatingBar(
                          itemSize: 20,
                          initialRating: 3.5,
                          minRating: 1,
                          maxRating: 5,
                          allowHalfRating: true,
                          ratingWidget: RatingWidget(
                              full: Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              half: Icon(Icons.star_half_sharp,
                                  color: Colors.amber),
                              empty:
                                  Icon(Icons.star_border, color: Colors.amber)),
                          onRatingUpdate: (value) => null),
                      Gap(12),
                      Text('125 review')
                    ],
                  ),
                  Gap(15),
                  Text(product[getIndex].longDescription),
                  Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product[getIndex].price * product[getIndex].qty}',
                        style: AppTheme.kHeadingOne,
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(productNotifierProvider.notifier)
                                    .decreaseQty(product[getIndex].pid);
                              },
                              icon: Icon(
                                Icons.do_not_disturb_on_outlined,
                                size: 30,
                              ),
                            ),
                            Text(
                              product[getIndex].qty.toString(),
                              style: AppTheme.kCardTitle.copyWith(fontSize: 24),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(productNotifierProvider.notifier)
                                    .incrementQty(product[getIndex].pid);
                              },
                              icon: Icon(Icons.add_circle_outline, size: 30),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        minimumSize: Size(double.infinity, 60)),
                    onPressed: () {
                      ref
                          .read(productNotifierProvider.notifier)
                          .isSelecItem(product[getIndex].pid, getIndex);

                      // Item add to bag
                      if (product[getIndex].isSelected == false) {
                        ref.read(itemBagProvider.notifier).addNewItemBag(
                            ProductModel(
                                pid: product[getIndex].pid,
                                imgUrl: product[getIndex].imgUrl,
                                title: product[getIndex].title,
                                price: product[getIndex].price,
                                shortDescription:
                                    product[getIndex].shortDescription,
                                longDescription:
                                    product[getIndex].longDescription,
                                reviews: product[getIndex].reviews,
                                rating: product[getIndex].rating));
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
                              product[getIndex].pid,
                            );
                        StatusAlert.show(
                          context,
                          duration: Duration(seconds: 2),
                          title: 'Remove To Bag',
                          subtitle: 'Item has be removed to bag',
                          configuration: IconConfiguration(icon: Icons.delete),
                          maxWidth: 300,
                        );
                      }
                    },
                    child: Text(product[getIndex].isSelected
                        ? 'Item has been added to bag'
                        : 'Add item to bag'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) =>
              ref.read(currentIndexProvider.notifier).update((state) => value),
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kSecondaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favorite',
              activeIcon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Location',
              activeIcon: Icon(Icons.location_on),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notification',
              activeIcon: Icon(Icons.notifications),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
              activeIcon: Icon(Icons.person),
            ),
          ]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_app/controllers/product_provider.dart';
import 'package:online_shop_app/models/sneakers_model.dart';
import 'package:online_shop_app/views/presentation/product_by_cart.dart';
import 'package:online_shop_app/views/presentation/product_page.dart';
import 'package:online_shop_app/views/shared/appstyle.dart';
import 'package:online_shop_app/views/shared/new_shoes.dart';
import 'package:online_shop_app/views/shared/product_card.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  })  : _male = male,
        super(key: key);
  final int tabIndex;
  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.440,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            productNotifier.shoeSizes = shoe.sizes;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        id: shoe.id, category: shoe.category)));
                          },
                          child: ProductCard(
                              price: "\$${shoe.price}",
                              category: shoe.category,
                              id: shoe.id,
                              name: shoe.name,
                              image: shoe.imageUrl[0]),
                        );
                      });
                }
              },
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Shoes',
                    style: appStyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductByCart(tabIndex: tabIndex)));
                    },
                    child: Text(
                      'Show All',
                      style: appStyle(22, Colors.black, FontWeight.bold),
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.right_chevron,
                    size: 20,
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewShoes(imageUrl: shoe.imageUrl[1]),
                        );
                      });
                }
              },
            )),
      ],
    );
  }
}

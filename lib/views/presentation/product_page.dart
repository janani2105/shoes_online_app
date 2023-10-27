import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:online_shop_app/controllers/cart_provider.dart';
import 'package:online_shop_app/controllers/favourites_provider.dart';
import 'package:online_shop_app/controllers/product_provider.dart';
import 'package:online_shop_app/models/sneakers_model.dart';
import 'package:online_shop_app/views/presentation/favourites.dart';
import 'package:online_shop_app/views/shared/appstyle.dart';
import 'package:online_shop_app/views/shared/checkout_btn.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.id, required this.category})
      : super(key: key);

  final String id;
  final String category;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context, listen: true);
    productNotifier.getShoes(widget.category, widget.id);
    var cartNotifier = Provider.of<CartProvider>(context, listen: true);
    cartNotifier.getCart();
    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future: productNotifier.sneakers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final sneaker = snapshot.data;
                return Consumer<ProductNotifier>(
                    builder: (context, productNotifier, child) {
                  return Builder(builder: (context) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    productNotifier.shoeSizes.clear();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: const Icon(
                                    Ionicons.ellipsis_horizontal,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          pinned: true,
                          snap: false,
                          floating: true,
                          backgroundColor: Colors.transparent,
                          expandedHeight: MediaQuery.of(context).size.height,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      controller: pageController,
                                      onPageChanged: (page) {
                                        productNotifier.activepage = page;
                                      },
                                      itemCount: sneaker!.imageUrl.length,
                                      itemBuilder: (context, int index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.39,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.grey.shade300,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    sneaker.imageUrl[index],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                right: 20,
                                                child: Consumer<
                                                        FavouritesNotifier>(
                                                    builder: (context,
                                                        favouritesNotifier,
                                                        child) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (favouritesNotifier.ids
                                                          .contains(
                                                              widget.id)) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const Favourites()));
                                                      } else {
                                                        favouritesNotifier
                                                            .createFav({
                                                          "id": sneaker.id,
                                                          "name": sneaker.name,
                                                          "category":
                                                              sneaker.category,
                                                          "price":
                                                              sneaker.price,
                                                          "imageUrl": sneaker
                                                              .imageUrl[0]
                                                        });
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: favouritesNotifier
                                                            .ids
                                                            .contains(
                                                                sneaker.id)
                                                        ? const Icon(
                                                            Ionicons.heart,
                                                            color: Colors.grey,
                                                          )
                                                        : const Icon(
                                                            Ionicons
                                                                .heart_outline,
                                                            color: Colors.grey,
                                                          ),
                                                  );
                                                })),
                                            Positioned(
                                                bottom: 0,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                right: 0,
                                                left: 0,
                                                child: (Row(
                                                    children:
                                                        List<Widget>.generate(
                                                            sneaker.imageUrl
                                                                .length,
                                                            (index) => Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        4,
                                                                  ),
                                                                  child: CircleAvatar(
                                                                      radius: 5,
                                                                      backgroundColor: productNotifier.activepage !=
                                                                              index
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .black),
                                                                ))))),
                                          ],
                                        );
                                      }),
                                ),
                                Positioned(
                                  bottom: 30,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.645,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              sneaker.name,
                                              style: appStyle(40, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  sneaker.category,
                                                  style: appStyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 4,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 22,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(vertical: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    size: 18,
                                                    color: Colors.black,
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${sneaker.price}",
                                                  style: appStyle(
                                                      26,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Colors",
                                                      style: appStyle(
                                                          18,
                                                          Colors.black,
                                                          FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.black,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Select sizes",
                                                      style: appStyle(
                                                          20,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      "View Size guide",
                                                      style: appStyle(
                                                          20,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                      itemCount: productNotifier
                                                          .shoeSizes.length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final sizes =
                                                            productNotifier
                                                                    .shoeSizes[
                                                                index];
                                                        return ChoiceChip(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        90),
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1),
                                                          ),
                                                          disabledColor:
                                                              Colors.white,
                                                          label: Text(
                                                            sizes['size'],
                                                            style: appStyle(
                                                                18,
                                                                sizes['isSelected']
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          selectedColor:
                                                              Colors.black,
                                                          selected: sizes[
                                                              'isSelected'],
                                                          onSelected:
                                                              (newState) {
                                                            if (productNotifier
                                                                .sizes
                                                                .contains(sizes[
                                                                    'size'])) {
                                                              productNotifier
                                                                  .sizes
                                                                  .remove(sizes[
                                                                      'size']);
                                                            } else {
                                                              productNotifier
                                                                  .sizes
                                                                  .add(sizes[
                                                                      'size']);
                                                            }
                                                            productNotifier
                                                                .toggleCheck(
                                                                    index);
                                                          },
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(
                                                sneaker.title,
                                                style: appStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              sneaker.description,
                                              textAlign: TextAlign.justify,
                                              maxLines: 4,
                                              style: appStyle(12, Colors.grey,
                                                  FontWeight.normal),
                                            ),
                                            /*      SizedBox(
                                              height: 10,
                                            ),*/
                                            Expanded(
                                              child: CheckoutButton(
                                                label: "Add to Cart",
                                                onTap: () async {
                                                  cartNotifier.createCart({
                                                    'id': sneaker.id,
                                                    'name': sneaker.name,
                                                    'sizes':
                                                        productNotifier.sizes,
                                                    'category':
                                                        sneaker.category,
                                                    'imageUrl':
                                                        sneaker.imageUrl[0],
                                                    'price': sneaker.price,
                                                    'qty': 1
                                                  });
                                                  //productNotifier.sizes.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
                });
              }
            }));
  }
}

import 'package:flutter/material.dart';
import 'package:online_shop_app/controllers/product_provider.dart';
import 'package:online_shop_app/views/shared/appstyle.dart';
import 'package:online_shop_app/views/shared/category_btn.dart';
import 'package:online_shop_app/views/shared/custom_spacer.dart';
import 'package:online_shop_app/views/shared/latest_shoes.dart';
import 'package:provider/provider.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({Key? key, required this.tabIndex}) : super(key: key);
  final int tabIndex;
  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKids();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/top_image.png",
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      6,
                      12,
                      16,
                      18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            Icons.landslide_rounded,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: const [
                        Tab(
                          text: 'Men Shoes',
                        ),
                        Tab(
                          text: 'Women Shoes',
                        ),
                        Tab(
                          text: 'Kid Shoes',
                        )
                      ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.175,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestShoes(
                    male: productNotifier.male,
                  ),
                  LatestShoes(
                    male: productNotifier.female,
                  ),
                  LatestShoes(
                    male: productNotifier.kids,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        CustomSpacer(),
                        Text(
                          "Filter",
                          style: appStyle(40, Colors.black, FontWeight.bold),
                        ),
                        CustomSpacer(),
                        Text(
                          "Gender",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CategoryBtn(buttonClr: Colors.black, label: "Men"),
                            CategoryBtn(
                                buttonClr: Colors.black, label: "Women"),
                            CategoryBtn(buttonClr: Colors.black, label: "Kids"),
                          ],
                        ),
                        CustomSpacer(),
                        Text(
                          "Category",
                          style: appStyle(20, Colors.black, FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CategoryBtn(buttonClr: Colors.grey, label: "Shoes"),
                            CategoryBtn(
                                buttonClr: Colors.black, label: "Apparels"),
                            CategoryBtn(
                                buttonClr: Colors.black, label: "Accessories"),
                          ],
                        ),
                        CustomSpacer(),
                        Text(
                          "Price",
                          style: appStyle(20, Colors.black, FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Slider(
                            value: _value,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.black,
                            label: _value.toString(),
                            max: 500,
                            divisions: 15,
                            secondaryTrackValue: 200,
                            onChanged: (double value) {}),
                        Text(
                          "Brand",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 65,
                          child: ListView.builder(
                              itemCount: brand.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        )),
                                    child: Image.asset(brand[index]),
                                    height: 50,
                                    width: 80,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shop_app/models/sneakers_model.dart';
import 'package:online_shop_app/views/presentation/product_page.dart';
import 'package:online_shop_app/views/shared/staggered_tile.dart';

class LatestShoes extends StatefulWidget {
  const LatestShoes({Key? key, this.male}) : super(key: key);
  final male;
  @override
  State<LatestShoes> createState() => _LatestShoesState();
}

class _LatestShoesState extends State<LatestShoes> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: widget.male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final male = snapshot.data;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisSpacing: 20,
            itemCount: male?.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final shoe = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(
                              id: shoe.id, category: shoe.category)));
                },
                child: StaggeredFile(
                    imageUrl: shoe.imageUrl[0],
                    name: shoe.name,
                    price: "\$${shoe.price}"),
              );
            },
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            staggeredTileBuilder: (int index) => StaggeredTile.extent(
                (index % 2 == 0) ? 1 : 1,
                (index % 4 == 1 || index % 4 == 3)
                    ? MediaQuery.of(context).size.height * 0.35
                    : MediaQuery.of(context).size.height * 0.3),
          );
        }
      },
    );
  }
}

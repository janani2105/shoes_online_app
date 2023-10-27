import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_app/views/shared/appstyle.dart';

class StaggeredFile extends StatefulWidget {
  const StaggeredFile(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.price})
      : super(key: key);
  final String imageUrl;
  final String name;
  final String price;
  @override
  State<StaggeredFile> createState() => _StaggeredFileState();
}

class _StaggeredFileState extends State<StaggeredFile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.imageUrl,
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              height: 73,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appStyleWithHt(20, Colors.black, FontWeight.w700, 1),
                  ),
                  Text(
                    widget.price,
                    style: appStyleWithHt(20, Colors.black, FontWeight.w500, 1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

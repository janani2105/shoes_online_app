import 'package:flutter/material.dart';
import 'package:online_shop_app/views/shared/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {Key? key, this.onPress, required this.buttonClr, required this.label})
      : super(key: key);
  final void Function()? onPress;
  final Color buttonClr;
  final String label;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: buttonClr, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: Text(
          label,
          style: appStyle(20, buttonClr, FontWeight.w600),
        ),
      ),
    );
  }
}

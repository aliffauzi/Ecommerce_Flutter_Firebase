import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleOnTap(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: mPrimaryGradientColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              category.iconPath,
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleOnTap(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.SHOW_ALL,
    );
  }
}
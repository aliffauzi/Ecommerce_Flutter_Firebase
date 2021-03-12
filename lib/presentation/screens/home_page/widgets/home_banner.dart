import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/presentation/widgets/others/shimmer_image.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  final List<BannerItem> banners;

  const HomeBanner({Key? key, required this.banners}) : super(key: key);
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List<BannerItem> get banners => widget.banners;
  final double aspectRatioBanner = 2 / 1;
  // local states

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      decoration: BoxDecoration(gradient: mPrimaryGradientColor),
      child: Stack(
        children: <Widget>[
          /// Banner images
          CarouselSlider(
            options: CarouselOptions(
              pageViewKey: PageStorageKey("home_banner"),
              aspectRatio: aspectRatioBanner,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.linearToEaseOut,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() => currentIndex = index);
              },
            ),
            items: banners.map((banner) {
              return ShimmerImage(
                aspectRatio: aspectRatioBanner,
                imageUrl: banner.imageUrl,
                borderRadius: BorderRadius.circular(10),
                fit: BoxFit.contain,
              );
            }).toList(),
          ),

          /// Bottom Left Dots
          _buildIndicators(),
        ],
      ),
    );
  }

  _buildIndicators() {
    return Positioned(
      top: SizeConfig.defaultSize * 1.5,
      right: SizeConfig.defaultSize * 1.5,
      child: Row(
        children: [
          ...List.generate(banners.length, (index) {
            return _buildIndicatorNormal(index == currentIndex);
          })
        ],
      ),
    );
  }

  _buildIndicatorNormal(bool isSelected) {
    return AnimatedContainer(
      duration: mAnimationDuration,
      height: SizeConfig.defaultSize,
      width: SizeConfig.defaultSize,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : mDarkShadeColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
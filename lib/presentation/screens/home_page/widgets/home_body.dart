import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/home_page/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/presentation/screens/home_page/widgets/home_banner.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoaded) {
            var homeResponse = homeState.homeResponse;
            return SingleChildScrollView(
              child: Column(
                children: [
                  HomeBanner(banners: homeResponse.banners),
                  _buildHomeCategories(context, homeResponse.categories),
                  _buildPopularProducts(context, homeResponse.popularProducts),
                  _buildDiscountProducts(
                      context, homeResponse.discountProducts),
                ],
              ),
            );
          }
          if (homeState is HomeLoading) {
            return Loading();
          }
          if (homeState is HomeLoadFailure) {
            return Center(child: Text(homeState.error));
          }
          return Center(child: Text("Something went wrong."));
        },
      ),
    );
  }

  _buildPopularProducts(BuildContext context, List<Product> popularProducts) {
    return SectionWidget(
      title: Translate.of(context).translate('popular_products'),
      children: popularProducts.map((p) => ProductCard(product: p)).toList(),
    );
  }

  _buildDiscountProducts(BuildContext context, List<Product> discountProducts) {
    return SectionWidget(
      title: Translate.of(context).translate('discount_products'),
      children: discountProducts.map((p) => ProductCard(product: p)).toList(),
    );
  }

  _buildHomeCategories(BuildContext context, List<Category> categories) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 931 / 485,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(
                  category: categories[index],
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.ALL_PRODUCTS,
                      arguments: categories[index],
                    );
                  });
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:e_commerce_app/views/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsBloc, AllProductsState>(
      buildWhen: (prevState, currState) {
        return true;
      },
      builder: (context, state) {
        if (state is DisplayListProducts) {
          if (state.loading) {
            return Loading();
          }
          if (state.msg.isNotEmpty) {
            return Center(child: Text(state.msg));
          }
          if (state.productsByCategory.length > 0) {
            var products = state.productsByCategory;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 10,
                crossAxisSpacing: 0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          }
          return Center(child: Text("No product."));
        } else {
          return Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/home_page/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/home_page/widgets/home_body.dart';
import 'package:e_commerce_app/presentation/screens/home_page/widgets/home_header.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        bannerRepository: RepositoryProvider.of<BannerRepository>(context),
        productRepository: RepositoryProvider.of<ProductRepository>(context),
      )..add(LoadHome()),
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: HomePersistentHeader(),
                pinned: true,
              ),
              HomeBody(),
            ],
          ),
          bottomNavigationBar: CustomBottomNav(selectedMenu: MenuState.home),
        ),
      ),
    );
  }
}
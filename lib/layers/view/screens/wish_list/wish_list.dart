import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../../../core/app/state/app_state.dart';
import '../../../data/model/product.dart';
import '../../widgets/product_card.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          final provider = Provider.of<AppState>(context, listen: true);
          if (provider.wishProducts.isNotEmpty) {
            return AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GridView.builder(
                    key: PageStorageKey("products"),
                    physics: const ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 7,
                        mainAxisExtent: 270.0),
                    itemCount: provider.wishProducts.length,
                    itemBuilder: (context, index) {
                      Product product =
                          provider.wishProducts[index].toProduct();
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 2,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                            delay: Duration(milliseconds: 275),
                            child: ProductCard(
                              onTapFavorite: () {},
                              onTap: () {},
                              product: product,
                            )),
                      );
                    }),
              ),
            );
          } else {
            return Center(
              child: Text("There is not any item in wish list!"),
            );
          }
        }),
      ),
    );
  }
}

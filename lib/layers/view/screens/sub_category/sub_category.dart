import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fresh_shelf/core/configuration/styles.dart';
import 'package:fresh_shelf/core/ui/responsive_text.dart';
import 'package:fresh_shelf/l10n/local_provider.dart';
import 'package:fresh_shelf/layers/bloc/product/product_cubit.dart';
import 'package:fresh_shelf/layers/bloc/sub_category/sub_category_cubit.dart';
import 'package:fresh_shelf/layers/data/model/product.dart';
import 'package:fresh_shelf/layers/data/model/sub_category.dart';
import 'package:fresh_shelf/layers/view/widgets/product_card.dart';
import '../../../../core/ui/waiting_widget.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, required this.categoryId});
  final int categoryId;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int _selectedIndex = 0;
  TextEditingController _titleController = TextEditingController();

  final _subCategoryCubit = sl<SubCategoryCubit>();
  final _productCubit = sl<ProductCubit>();

  String lastSearch = '';
  final _searchDelayer = Debouncer();

  loadData() {
    _subCategoryCubit.getSubCategories(widget.categoryId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SubCategoryCubit, SubCategoryState>(
        bloc: _subCategoryCubit,
        builder: (context, state) {
          if (state is SubCategoryLoading) {
            return Center(
              child: WaitingWidget(),
            );
          } else if (state is SubCategoryError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is SubCategoryLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _titleController,
                    maxLines: 1,
                    textDirection: sl<LocaleProvider>().locale != null
                        ? sl<LocaleProvider>().locale!.languageCode != 'ar'
                            ? TextDirection.ltr
                            : TextDirection.rtl
                        : TextDirection.ltr,
                    textAlign: sl<LocaleProvider>().locale != null
                        ? sl<LocaleProvider>().locale!.languageCode != 'ar'
                            ? TextAlign.left
                            : TextAlign.right
                        : TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.search,
                          color: Styles.colorPrimary,
                        ),
                      ),
                      hintText: S.of(context).search,
                      hintStyle:
                          TextStyle(fontSize: 14, color: Styles.colorPrimary),
                    ),
                    onChanged: (value) {
                      if (value != lastSearch) {
                        lastSearch = value;
                        _searchDelayer.run(() {
                          _productCubit.getProducts(
                              state.subCategories[_selectedIndex].id,
                              name: value);
                        });
                      }
                    },
                  ),
                ),
                CommonSizes.vBigSpace,
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    itemCount: state.subCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      SubCategory subCategory = state.subCategories[index];
                      return GestureDetector(
                        onTap: () {
                          _productCubit.getProducts(subCategory.id);
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(30),
                                  border: _selectedIndex == index
                                      ? Border.all(
                                          width: 3, color: Styles.colorPrimary)
                                      : null),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  width: 60,
                                  height: 60,
                                  imageUrl: subCategory.picture,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CommonSizes.vSmallestSpace,
                            SizedBox(
                                width: 60,
                                child: ResponsiveText(
                                  textWidget: Text(
                                    subCategory.name,
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                    child: BlocBuilder<ProductCubit, ProductState>(
                  bloc: _productCubit,
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(
                        child: WaitingWidget(),
                      );
                    } else if (state is ProductError) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is ProductLoaded) {
                      if (state.products.isNotEmpty) {
                        return AnimationLimiter(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GridView.builder(
                                key: PageStorageKey("products"),
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 7,
                                        mainAxisSpacing: 7,
                                        mainAxisExtent: 270.0),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  Product product = state.products[index];
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
                          child:
                              Text(S.of(context).noProductName),
                        );
                      }
                    }
                    return SizedBox();
                  },
                ))
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

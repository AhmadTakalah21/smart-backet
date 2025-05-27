import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/core/configuration/styles.dart';
import 'package:fresh_shelf/core/routing/route_path.dart';
import 'package:fresh_shelf/core/ui/responsive_text.dart';
import 'package:fresh_shelf/layers/bloc/category/category_cubit.dart';
import 'package:fresh_shelf/layers/data/model/category.dart';
import '../../../../core/ui/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../widgets/carousel_slider.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categoryCubit = sl<CategoryCubit>();

  loadData() {
    _categoryCubit.getCategories();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!(_categoryCubit.state is CategoryLoaded)) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: WaitingWidget(),
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is CategoryLoaded) {
            return SafeArea(
              child: ListView(
                children: [
                  CarouselSlider(
                    imagesUrl: [
                      "https://www.yellowpagesegypt.net/Produits/juhayna/galerie/galerie5.jpg",
                      "https://insightstudios.sa/wp-content/uploads/2023/05/insight-studios-ad-img5.jpg"
                    ],
                    isNetWork: true,
                    autoScroll: true,
                  ),
                  CommonSizes.vSmallSpace,
                  Text(
                    S.of(context).categories,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.0, crossAxisCount: 2),
                    itemCount: state.categories.length,
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true, // You won't see infinite size error
                    itemBuilder: (context, index) {
                      Category category = state.categories[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            RoutePaths.SubCategory,
                            arguments: {"categoryId": category.id}),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Styles.colorPrimary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                top: 5,
                                bottom: 5,
                                right: 5,
                                left: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: category.picture,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.black.withOpacity(0.7)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )),
                              ),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ResponsiveText(
                                  textWidget: Text(
                                    category.name,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

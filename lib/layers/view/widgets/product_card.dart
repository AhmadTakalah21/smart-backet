import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_shelf/core/configuration/styles.dart';
import 'package:fresh_shelf/layers/data/model/product.dart';
import 'package:fresh_shelf/layers/view/widgets/show_product.dart';

import '../../../core/ui/custom_image.dart';
import '../../../core/ui/responsive_text.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double width;
  final double height;
  final GestureTapCallback? onTapFavorite;
  final GestureTapCallback? onTap;

  const ProductCard({
    Key? key,
    this.width = 280,
    this.height = 325, //300
    this.onTap,
    this.onTapFavorite,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProductDialog(product: this.product).showDialog(context);
      },
      child: Container(
        width: width,
        height: height.h,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Styles.colorPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomImage(
                product.picture!,
                width: double.infinity,
                bgColor: Colors.grey.shade300,
                isNetwork: true,
                radius: 15,
              ),
            ),
            Container(
              width: width - 20,
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildName(),
                  SizedBox(
                    height: 2,
                  ),
                  _buildInfo(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return ResponsiveText(
      textWidget: Text(
        "${product.name}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveText(
              textWidget: Text(
                "${product.price} SYR",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

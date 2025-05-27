import 'package:flutter/material.dart';

import '../../../core/configuration/styles.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget(
      {super.key,
      required this.title,
      required this.child,
      this.textStyle,
      this.padding});
  final Widget child;
  final String title;
  final TextStyle? textStyle;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding ?? 20.0),
          child: Text(
            title,
            style: textStyle ??
                TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "Lora",
                    letterSpacing: 3),
          ),
        ),
        CommonSizes.vSmallerSpace,
        child
      ],
    );
  }
}

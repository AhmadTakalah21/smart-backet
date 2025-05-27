import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../../core/configuration/styles.dart';
import '../../../../../core/utils/size_config.dart';


class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight,
        ),
        Positioned(
          top: -50,
          right: -10,
          child: FadeInDown(
            duration: Duration(seconds: 1),
            child: Container(
              width: SizeConfig.screenWidth * 0.3,
              height: SizeConfig.screenWidth * 0.3,
              decoration: BoxDecoration(
                  color: Styles.colorSecondary, shape: BoxShape.circle),
            ),
          ),
        ),
        Positioned(
          top: -170,
          left: -10,
          child: FadeInDown(
            duration: Duration(milliseconds: 1300),
            child: Stack(
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.8,
                  height: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Styles.colorPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned.fill(
                  bottom: 40,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Styles.colorSecondary,
                              shape: BoxShape.circle),
                        ),
                        CommonSizes.hBiggerSpace,
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Styles.colorSecondary,
                              shape: BoxShape.circle),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: FadeInUp(
            duration: Duration(milliseconds: 1300),
            child: Stack(
              children: [
                Container(
                  height: 130,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Styles.colorPrimary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                ),
                Positioned.fill(
                  top: 30,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Styles.colorSecondary,
                              shape: BoxShape.circle),
                        ),
                        CommonSizes.hBigSpace,
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Styles.colorSecondary,
                              shape: BoxShape.circle),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

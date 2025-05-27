import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/configuration/styles.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            colors: [Styles.colorPrimary, Styles.colorSecondary]),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

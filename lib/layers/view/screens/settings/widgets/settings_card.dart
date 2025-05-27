import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? child;
  final Function? fun;

  const SettingsCard({
    Key? key,
    required this.icon,
    required this.title,
    this.child,
    this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (fun != null) {
          fun!();
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
          child ??
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.arrow_forward_ios, size: 25),
              )
        ],
      ),
    );
  }
}

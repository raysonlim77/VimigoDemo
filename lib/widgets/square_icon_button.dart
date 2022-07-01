import 'package:flutter/material.dart';

import '../configs/colors.dart';

class SquareIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? color;
  const SquareIconButton({
    Key? key,
    this.icon,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (icon == null) {
      return Container(
        height: size.width * 0.08,
        width: size.width * 0.08,
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: size.width * 0.08,
            width: size.width * 0.08,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color!.withOpacity(0.2),
                  offset: Offset(5, 10),
                  spreadRadius: 3,
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  offset: Offset(-3, -4),
                  spreadRadius: -2,
                  blurRadius: 20,
                )
              ],
              color: Colors.white60,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          IconButton(
            icon: Icon(
              icon,
              size: size.width * 0.05,
              color: darkGrey,
            ),
            onPressed: onPressed,
          ),
        ],
      );
    }
  }
}

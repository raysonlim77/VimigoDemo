import 'package:flutter/material.dart';

class AppPushButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onTap;
  final double width;
  final Color mainColor;
  AppPushButton({
    required this.text,
    required this.onTap,
    required this.fontSize,
    required this.width,
    required this.mainColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width * 0.5,
          height: width * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                mainColor.withOpacity(0.4),
                mainColor.withOpacity(0.7),
                mainColor,
                mainColor.withOpacity(0.7),
                mainColor.withOpacity(0.4),
              ],
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.5, 0.5),
                color: mainColor,
                blurRadius: 2,
              ),
              BoxShadow(
                offset: Offset(-0.5, -0.5),
                color: mainColor,
                blurRadius: 2,
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xffffffff),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vimogo/widgets/text_stroke_widget.dart';

import '../configs/colors.dart';
import '../models/users.dart';

class AvatarTextFrame extends StatelessWidget {
  const AvatarTextFrame({
    Key? key,
    required this.width,
    required this.user,
    required this.frameUrl,
    required this.isTopThree,
  }) : super(key: key);

  final double width;
  final User user;
  final String frameUrl;
  final bool isTopThree;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: (isTopThree) ? width * 0.6 : width * 0.82,
            height: (isTopThree) ? width * 0.6 : width * 0.82,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                  image: AssetImage(user.photoUrl),
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(0)),
                image: DecorationImage(
                  image: AssetImage(frameUrl),
                  fit: BoxFit.contain,
                )),
          ),
          if (isTopThree)
            Positioned(
              bottom: width * 0.06,
              child: Container(
                width: width * 0.55,
                child: TextStrokeWidget(
                  "${user.name}",
                  fontFamily: "Riffic",
                  color: AppColor.lightForegroundColor,
                  fontSize: width * 0.04,
                  strokeWidth: width * 0.0001,
                  strokeColor: Colors.black,
                  overrideSizeStroke: true,
                  shadow: const [
                    Shadow(blurRadius: 8, offset: Offset(0, 0.1)),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

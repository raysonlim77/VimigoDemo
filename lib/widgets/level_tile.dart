import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../configs/colors.dart';
import '../configs/custom_format.dart';
import '../models/levels.dart';
import '../models/users.dart';
import 'lottie_animation.dart';
import 'radial_progress.dart';
import 'text_stroke_widget.dart';

class LevelTile extends StatelessWidget {
  final Levels level;
  final User user;
  final Color newColor;
  final bool isFirst;
  final bool isCurrent;
  final bool isLast;
  final bool isDone;
  final bool isOdd;
  final bool isNextTarget;
  const LevelTile({
    Key? key,
    required this.level,
    required this.user,
    this.newColor = const Color(0xfffbb040),
    this.isCurrent = false,
    this.isFirst = false,
    this.isLast = false,
    this.isDone = false,
    this.isOdd = false,
    this.isNextTarget = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color getColor =
        (isDone) ? newColor.withOpacity(1.0) : AppColor.lightForegroundColor;

    return Column(
      children: [
        Container(
          width: size.width * 1,
          child: Stack(alignment: Alignment.center, children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1, vertical: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: CustomPaint(
                                size: Size(size.width * 0.45,
                                    (70 * 0.8217391304347826).toDouble()),
                                painter: TopLeftCustomPainter(isFirst
                                    ? Colors.transparent
                                    : isOdd
                                        ? isCurrent
                                            ? AppColor.lightForegroundColor
                                            : getColor
                                        : Colors.transparent),
                              ),
                            ),
                            if (!isFirst)
                              Expanded(
                                child: CustomPaint(
                                  size: Size(size.width * 0.45,
                                      (70 * 0.8217391304347826).toDouble()),
                                  painter: TopRightCustomPainter((isOdd)
                                      ? Colors.transparent
                                      : isCurrent
                                          ? AppColor.lightForegroundColor
                                          : getColor),
                                ),
                              )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (!isLast)
                              Expanded(
                                child: CustomPaint(
                                  size: Size(size.width * 0.45,
                                      (70 * 0.8217391304347826).toDouble()),
                                  painter: BottomLeftCustomPainter(
                                      (isOdd && !isLast)
                                          ? getColor
                                          : Colors.transparent),
                                ),
                              ),
                            Expanded(
                              child: CustomPaint(
                                size: Size(size.width * 0.45,
                                    (70 * 0.8217391304347826).toDouble()),
                                painter: BottomRightCustomPainter((isOdd)
                                    ? Colors.transparent
                                    : isCurrent
                                        ? newColor
                                        : getColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      left: isOdd ? size.width * 0.1 : size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            level.title,
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: darkGrey,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (level.tier == 0)
                                ? "Target: --"
                                : "Target: ${CustomFormat.formatRmPrice(level.target)}",
                            style: TextStyle(
                              color: darkGrey,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Reward: ${level.reward}.00%",
                            style: TextStyle(
                              color: darkGrey,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                (level.tier == 0)
                                    ? "Potential: --"
                                    : "Potential: 💰${CustomFormat.formatRmPrice(Levels.getCommission(level.target)!)} ",
                                style: TextStyle(
                                  color: darkGrey,
                                  fontSize: size.width * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: isOdd ? size.width * 0.02 : null,
              right: isOdd ? null : size.width * 0.02,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: size.width * 0.15,
                      height: size.width * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: AppColor.lightForegroundColor,
                        gradient: LinearGradient(
                          colors: isDone
                              ? [
                                  AppColor.lightForegroundColor.withOpacity(1),
                                  AppColor.lightForegroundColor.withOpacity(1),
                                ]
                              : [
                                  AppColor.darkForegroundColor.withOpacity(0.2),
                                  AppColor.darkForegroundColor.withOpacity(0.2),
                                ],
                        ),
                      ),
                    ),
                    RadialProgress(
                      width: size.width * 0.016,
                      progressColor: (isCurrent || isDone || isNextTarget)
                          ? newColor
                          : AppColor.lightForegroundColor,
                      progressBackgroundColor: AppColor.lightForegroundColor,
                      goalCompleted:
                          isNextTarget ? user.sales / level.target : 1,
                      isAnimated: isNextTarget ? true : false,
                      child: SizedBox(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                      ),
                    ),
                    (isNextTarget)
                        ? TextStrokeWidget(
                            "${((user.sales / level.target) * 100).toStringAsFixed(0)}%",
                            fontFamily: "Riffic",
                            color: AppColor.lightForegroundColor,
                            fontSize: size.width * 0.009,
                            strokeWidth: size.width * 0.0001,
                            strokeColor: Colors.black,
                            overrideSizeStroke: true,
                            shadow: const [
                              Shadow(blurRadius: 8, offset: Offset(0, 0.1)),
                            ],
                          )
                        : isDone
                            ? Image.asset(
                                "assets/coin.gif",
                                width: size.width * 0.13,
                                height: size.width * 0.13,
                              )
                            : ColorFiltered(
                                colorFilter: ColorFilter.matrix(
                                  GREYSCALE_MATRIX,
                                ),
                                child: Image.asset(
                                  "assets/coin.gif",
                                  width: size.width * 0.13,
                                  height: size.width * 0.13,
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class TopRightCustomPainter extends CustomPainter {
  final Color color;

  TopRightCustomPainter(
    this.color,
  );
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();

    path_0.moveTo(0, size.height * 0.03306878);
    path_0.lineTo(size.width * 0.6419609, size.height * 0.03306878);
    path_0.cubicTo(
        size.width * 0.8343060,
        size.height * 0.03306878,
        size.width * 0.9902247,
        size.height * 0.4659392,
        size.width * 0.9902247,
        size.height);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03945336;

    paint_0_stroke.color = color;
    canvas.drawPath(path_0, paint_0_stroke);
    List<Shadow> shadows = [
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(0.5),
      ),
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(1),
      ),
    ];
    if (color != Colors.transparent)
      shadows.forEach((s) {
        paint_0_stroke
          ..color = s.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, sqrt(s.blurRadius));
        canvas.save();
        canvas.translate(s.offset.dx, s.offset.dy);
        canvas.drawPath(path_0, paint_0_stroke);
        canvas.restore();
      });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TopLeftCustomPainter extends CustomPainter {
  final Color color;

  TopLeftCustomPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.009726680, size.height);
    path_0.cubicTo(
        size.width * 0.009726680,
        size.height * 0.4659392,
        size.width * 0.1656454,
        size.height * 0.03306878,
        size.width * 0.3579418,
        size.height * 0.03306878);
    path_0.lineTo(size.width * 0.9999027, size.height * 0.03306878);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03945336;
    paint_0_stroke.color = color;
    canvas.drawPath(path_0, paint_0_stroke);
    List<Shadow> shadows = [
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(0.5),
      ),
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(1),
      ),
    ];
    if (color != Colors.transparent)
      shadows.forEach((s) {
        paint_0_stroke
          ..color = s.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, sqrt(s.blurRadius));
        canvas.save();
        canvas.translate(s.offset.dx, s.offset.dy);
        canvas.drawPath(path_0, paint_0_stroke);
        canvas.restore();
      });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BottomRightCustomPainter extends CustomPainter {
  final Color color;

  BottomRightCustomPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9902733, 0);
    path_0.lineTo(size.width * 0.9902733, 0);
    path_0.cubicTo(
        size.width * 0.9902733,
        size.height * 0.5340608,
        size.width * 0.8343546,
        size.height * 0.9669312,
        size.width * 0.6420095,
        size.height * 0.9669312);
    path_0.lineTo(0, size.height * 0.9669312);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03945336;
    paint_0_stroke.color = color;
    canvas.drawPath(path_0, paint_0_stroke);
    List<Shadow> shadows = [
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(0.5),
      ),
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(1),
      ),
    ];
    if (color != Colors.transparent)
      shadows.forEach((s) {
        paint_0_stroke
          ..color = s.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, sqrt(s.blurRadius));
        canvas.save();
        canvas.translate(s.offset.dx, s.offset.dy);
        canvas.drawPath(path_0, paint_0_stroke);
        canvas.restore();
      });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BottomLeftCustomPainter extends CustomPainter {
  final Color color;

  BottomLeftCustomPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.009726680, 0);
    path_0.lineTo(size.width * 0.009726680, 0);
    path_0.cubicTo(
        size.width * 0.009726680,
        size.height * 0.5340608,
        size.width * 0.1656454,
        size.height * 0.9669312,
        size.width * 0.3579418,
        size.height * 0.9669312);
    path_0.lineTo(size.width * 0.9999027, size.height * 0.9669312);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03945336;
    paint_0_stroke.color = color;
    canvas.drawPath(path_0, paint_0_stroke);
    List<Shadow> shadows = [
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(0.5),
      ),
      Shadow(
        offset: Offset(2.5, 2.5),
        blurRadius: 6.0,
        color: color.withOpacity(1),
      ),
    ];
    if (color != Colors.transparent)
      shadows.forEach((s) {
        paint_0_stroke
          ..color = s.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, sqrt(s.blurRadius));
        canvas.save();
        canvas.translate(s.offset.dx, s.offset.dy);
        canvas.drawPath(path_0, paint_0_stroke);
        canvas.restore();
      });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

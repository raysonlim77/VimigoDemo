import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class RadialProgress extends StatefulWidget {
  final double goalCompleted;
  final Widget child;
  final Color progressColor;
  final Color progressBackgroundColor;
  final double width;
  final bool isAnimated;

  const RadialProgress(
      {Key? key,
      required this.child,
      this.goalCompleted = 0.7,
      this.progressColor = Colors.white,
      this.progressBackgroundColor = Colors.white,
      this.isAnimated = true,
      this.width = 8})
      : super(key: key);

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _radialProgressAnimationController;
  late Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(
      CurvedAnimation(
        parent: _radialProgressAnimationController,
        curve: Curves.easeIn,
      ),
    )..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    (widget.isAnimated)
        ? _radialProgressAnimationController.forward()
        : setState(() {
            progressDegrees = widget.goalCompleted * 360;
          });
    ;
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: widget.child,
      ),
      painter: RadialPainter(
        progressDegrees,
        widget.progressColor,
        widget.progressBackgroundColor,
        widget.width,
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees, width;
  final Color progressColor, progressBackgroundColor;

  RadialPainter(this.progressInDegrees, this.progressColor,
      this.progressBackgroundColor, this.width);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = progressBackgroundColor.withOpacity(1)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(progressInDegrees),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RoundedImage extends StatelessWidget {
  final String imagePath;
  final double width;

  const RoundedImage({
    Key? key,
    required this.imagePath,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imagePath,
        width: width,
        height: width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

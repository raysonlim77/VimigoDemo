import 'package:flutter/material.dart';

class CustomScrollableController {
  CustomScrollableInterface? _interface;

  set interface(CustomScrollableInterface value) {
    _interface = value;
  }

  void animateToFull(BuildContext context) {
    _interface?.animateToFull(context);
  }

  void animateToHalf(BuildContext context) {
    _interface?.animateToHalf(context);
  }

  void animateToMinimum(BuildContext context, {bool willPop = false}) {
    _interface?.animateToMinimum(context, willPop: willPop);
  }

  void animateToZero(BuildContext context, {bool willPop = false}) {
    _interface?.animateToZero(context, willPop: willPop);
  }

  void setHalfHeight(double newHalfHeight) {
    _interface?.setHalfHeight(newHalfHeight);
  }

  void setMinimumHeight(double newMinimumHeight) {
    _interface?.setMinimumHeight(newMinimumHeight);
  }
}

abstract class CustomScrollableInterface {
  void animateToFull(BuildContext context);

  void animateToHalf(BuildContext context);

  void animateToMinimum(BuildContext context, {bool willPop = false});

  void animateToZero(BuildContext context, {bool willPop = false});

  void setHalfHeight(double newHalfHeight);

  void setMinimumHeight(double newMinimumHeight);
}

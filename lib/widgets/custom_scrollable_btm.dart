import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'custom_scrollable_controller.dart';

typedef AnimationCallback = void Function(double value);
typedef StateCallback = void Function(ScrollState state);

class CustomScrollableBtm extends StatefulWidget {
  final CustomScrollableController controller;

  final double halfHeight;

  final Widget child;

  final bool snapAbove;

  final bool snapBelow;

  final bool autoPop;

  final double minimumHeight;

  final StateCallback? callback;

  final ScrollState firstScrollTo;

  final bool mayExceedChildHeight;

  CustomScrollableBtm({
    CustomScrollableController? controller,
    required this.halfHeight,
    required this.child,
    this.snapAbove = true,
    this.snapBelow = true,
    this.autoPop = true,
    this.minimumHeight = 0.0,
    this.firstScrollTo = ScrollState.half,
    this.mayExceedChildHeight = false,
    this.callback,
  }) : controller = controller ?? CustomScrollableController();

  @override
  State<StatefulWidget> createState() => _CustomScrollableBtmState();
}

class CustomScrollableBtmByContent extends StatefulWidget {
  final Widget header;
  final Widget content;
  final CustomScrollableController controller;
  final StateCallback? callback;
  final bool snapAbove;
  final bool snapBelow;
  final bool autoPop;
  final ScrollState scrollTo;

  CustomScrollableBtmByContent(
    this.header,
    this.content, {
    CustomScrollableController? controller,
    this.snapAbove = true,
    this.snapBelow = true,
    this.autoPop = true,
    this.scrollTo = ScrollState.minimum,
    this.callback,
  }) : controller = controller ?? CustomScrollableController();

  @override
  State<StatefulWidget> createState() => _CustomScrollableBtmByContentState();
}

enum ScrollDirection { none, up, down }

enum ScrollState { full, half, minimum }

class _CustomScrollableBtmByContentState
    extends State<CustomScrollableBtmByContent> {
  late BuildContext _headerContext;
  late BuildContext _contentContext;

  @override
  Widget build(BuildContext context) {
    return CustomScrollableBtm(
      controller: widget.controller,
      snapAbove: widget.snapAbove,
      snapBelow: widget.snapBelow,
      autoPop: widget.autoPop,
      callback: widget.callback,
      halfHeight: 0.0,
      child: Column(children: [
        Builder(
          builder: (BuildContext context) {
            _headerContext = context;
            return widget.header;
          },
        ),
        Builder(
          builder: (BuildContext context) {
            _contentContext = context;
            return widget.content;
          },
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.setMinimumHeight(_headerContext.size?.height ?? 0);
      widget.controller.setHalfHeight(
        (_headerContext.size?.height ?? 0) +
            (_contentContext.size?.height ?? 0),
      );

      if (widget.scrollTo == ScrollState.minimum) {
        widget.controller.animateToMinimum(context);
      } else if (widget.scrollTo == ScrollState.half) {
        widget.controller.animateToHalf(context);
      } else if (widget.scrollTo == ScrollState.full) {
        widget.controller.animateToFull(context);
      }
    });
  }
}

class _CustomScrollableBtmState extends State<CustomScrollableBtm>
    with TickerProviderStateMixin
    implements CustomScrollableInterface {
  double? _currentHeight;
  double _minimumHeight = 0;
  double _halfHeight = 0;
  bool _requestToFull = false;
  double _fullHeight = 0;
  double? _childHeight;
  final _scrollController = ScrollController();
  ScrollState? _currentState;
  late BuildContext _headerContext;
  AnimationController? _activeAnimController;

  ScrollDirection _lastScrollDirection = ScrollDirection.none;

  Drag? _drag;

  ScrollHoldController? _hold;

  @override
  void animateToFull(BuildContext context) {
    setState(() {
      _requestToFull = true;
    });
  }

  @override
  void animateToHalf(BuildContext context) {
    _animateTo(_halfHeight);
  }

  @override
  void animateToMinimum(BuildContext context, {bool willPop = false}) {
    _animateTo(
      _minimumHeight,
      onComplete: () {
        if (willPop) Navigator.pop(context);
      },
    );
  }

  @override
  void animateToZero(BuildContext context, {bool willPop = false}) {
    _animateTo(0.0, onComplete: () {
      if (willPop) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_requestToFull) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateTo(_fullHeight);
      });
      _requestToFull = false;
    }

    final Widget child = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (widget.mayExceedChildHeight) {
          _fullHeight = constraints.maxHeight;
        } else {
          _fullHeight = math.min(
            _childHeight ?? _minimumHeight,
            constraints.maxHeight,
          );
        }

        if (_currentHeight == null) {
          _currentHeight = widget.firstScrollTo == ScrollState.half
              ? _halfHeight
              : widget.firstScrollTo == ScrollState.full
                  ? _fullHeight
                  : widget.minimumHeight;
        } else if (_currentHeight! < widget.minimumHeight) {
          _currentHeight = widget.minimumHeight;
        }

        _currentHeight = _currentHeight!.clamp(_minimumHeight, _fullHeight);

        return SizedBox(
          height: _currentHeight,
          child: GestureDetector(
            onVerticalDragEnd: (DragEndDetails details) {
              double? targetHeight;

              if (_scrollController.position.pixels < 0.0) {
                _scrollController.position.animateTo(0.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }

              if (_currentHeight! <= _halfHeight) {
                if (widget.snapBelow &&
                    _scrollController.hasClients &&
                    _scrollController.position.pixels <= 0) {
                  if (_lastScrollDirection == ScrollDirection.down) {
                    targetHeight = _minimumHeight;
                  } else {
                    targetHeight = _halfHeight;
                  }
                }
              } else {
                if (widget.snapAbove &&
                    _scrollController.hasClients &&
                    _scrollController.position.pixels <= 0) {
                  if (_lastScrollDirection == ScrollDirection.down) {
                    targetHeight = _halfHeight;
                  } else {
                    targetHeight = _fullHeight;
                  }
                }
              }

              if (targetHeight != null) {
                _animateTo(targetHeight, onComplete: () {
                  if ((targetHeight == 0.0 || targetHeight == _minimumHeight) &&
                      widget.autoPop) Navigator.pop(context);
                });
              }

              _lastScrollDirection = ScrollDirection.none;

              if (_currentHeight! >= _fullHeight &&
                  _currentState != ScrollState.full) {
                _currentState = ScrollState.full;
                if (widget.callback != null) {
                  widget.callback?.call(_currentState!);
                }
              } else if (_currentState == ScrollState.full &&
                  _currentHeight! < _halfHeight) {
                _currentState = ScrollState.half;
                if (widget.callback != null) {
                  widget.callback?.call(_currentState!);
                }
              } else if (_currentState == ScrollState.minimum &&
                  _currentHeight! >= _halfHeight) {
                _currentState = ScrollState.half;
                if (widget.callback != null) {
                  widget.callback?.call(_currentState!);
                }
              } else if (_currentHeight! <= widget.minimumHeight &&
                  _currentState != ScrollState.minimum) {
                _currentState = ScrollState.minimum;
                if (widget.callback != null) {
                  widget.callback?.call(_currentState!);
                }
              }
              if (_currentHeight! >= _fullHeight) {
                _drag?.end(details);
              } else {
                _drag?.cancel();
              }
            },
            onVerticalDragDown: (DragDownDetails details) {
              _hold = _scrollController.position.hold(_disposeHold);
            },
            onVerticalDragCancel: () {
              _drag?.cancel();
              _hold?.cancel();
            },
            onVerticalDragUpdate: (DragUpdateDetails details) {
              if (details.primaryDelta! > 0) {
                _lastScrollDirection = ScrollDirection.down;

                if (_scrollController.offset <= 0.0) {
                  if (_currentHeight! > 0.0) {
                    if (mounted) {
                      setState(() {
                        _currentHeight =
                            _currentHeight! + details.primaryDelta! * -1;
                      });
                    }
                  }
                }
              } else if (details.primaryDelta! < 0) {
                _lastScrollDirection = ScrollDirection.up;

                if (_currentHeight! < _fullHeight) {
                  if (mounted) {
                    setState(() {
                      _currentHeight =
                          _currentHeight! + details.primaryDelta! * -1;
                    });
                  }
                }
              }

              if (_currentHeight! >= _fullHeight) {
                DragUpdateDetails d = details;

                if (_scrollController.offset - d.primaryDelta! < 0.0) {
                  final Offset newGlobalPosition = Offset(
                    details.globalPosition.dx,
                    details.globalPosition.dy -
                        d.primaryDelta! +
                        _scrollController.offset,
                  );
                  final Offset newDelta =
                      Offset(details.delta.dx, _scrollController.offset);

                  d = DragUpdateDetails(
                      delta: newDelta,
                      primaryDelta: _scrollController.offset,
                      globalPosition: newGlobalPosition,
                      sourceTimeStamp: details.sourceTimeStamp);
                }

                _drag?.update(d);
              }
            },
            onVerticalDragStart: (DragStartDetails details) {
              if (_scrollController.position.maxScrollExtent > 0.0) {
                _drag = _scrollController.position.drag(details, _disposeDrag);
              }
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: NeverScrollableScrollPhysics(),
              child: Builder(
                builder: (BuildContext c) {
                  _headerContext = c;

                  return widget.child;
                },
              ),
            ),
          ),
        );
      },
    );

    return child;
  }

  @override
  void dispose() {
    _activeAnimController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.interface = this;

    _minimumHeight = widget.minimumHeight;
    _halfHeight = widget.halfHeight;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _childHeight = _headerContext.size?.height;

      _currentState = widget.firstScrollTo;
      widget.callback?.call(widget.firstScrollTo);
    });
  }

  @override
  void setHalfHeight(double newHalfHeight) {
    _halfHeight = newHalfHeight;
  }

  @override
  void setMinimumHeight(double newMinimumHeight) {
    _minimumHeight = newMinimumHeight;
  }

  void _animateTo(double targetHeight, {VoidCallback? onComplete}) {
    if (!mounted) return;

    if (_scrollController.hasClients && _scrollController.position.pixels > 0) {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
    }

    final AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    _activeAnimController = animationController;

    final animation = CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.ease));

    final Animation<double> zeroScale =
        Tween<double>(begin: _currentHeight, end: targetHeight)
            .animate(animation);

    animationController.forward();

    void listener() {
      if (mounted) {
        setState(() {
          _currentHeight = zeroScale.value;

          if (zeroScale.value == targetHeight &&
              zeroScale.status == AnimationStatus.completed) {
            if (targetHeight == _fullHeight) {
              _currentState = ScrollState.full;
            } else if (targetHeight == _halfHeight) {
              _currentState = ScrollState.half;
            } else if (targetHeight == widget.minimumHeight) {
              _currentState = ScrollState.minimum;
            }

            if (onComplete != null) onComplete();
            animationController.dispose();
            _activeAnimController = null;

            widget.callback?.call(_currentState!);
          }
        });
      }
    }

    zeroScale.addListener(listener);
  }

  void _disposeDrag() {
    _drag = null;
  }

  void _disposeHold() {
    _hold = null;
  }
}

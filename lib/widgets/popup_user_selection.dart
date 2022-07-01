import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:vimogo/widgets/text_stroke_widget.dart';
import 'package:vimogo/widgets/text_widget.dart';

import '../configs/colors.dart';
import '../configs/custom_format.dart';
import '../models/users.dart';
import 'Avatar_Text_Frame.dart';

class PopUpUserSelection extends StatefulWidget {
  final User? user;
  final List<User>? users;
  final Function(User? user) onCallback;

  const PopUpUserSelection({
    Key? key,
    required this.user,
    required this.users,
    required this.onCallback,
  }) : super(key: key);

  @override
  _PopUpUserSelectionState createState() => _PopUpUserSelectionState();
}

class _PopUpUserSelectionState extends State<PopUpUserSelection> {
  bool isBannerVisible = true;
  User? selectedUser;
  @override
  void initState() {
    selectedUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    print("${widget.users!}");
    print("${widget.user!}");
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
        ),
        child: Material(
          color: Colors.transparent,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
                vertical: size.width * 0.00,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 7,
                          sigmaY: 7,
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 400),
                        ),
                      ),
                      Opacity(
                        opacity: 0.2,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 400),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/noise.png",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 400),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.25),
                            )
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.0,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.2)
                            ],
                            stops: [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedOpacity(
                                  duration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  opacity: isBannerVisible ? 1 : 0,
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 200,
                                    ),
                                    width: size.width * 0.65,
                                    height:
                                        isBannerVisible ? size.width * 0.12 : 0,
                                  ),
                                ),
                                Container(
                                  width: size.width * 1,
                                  constraints: BoxConstraints(
                                      maxHeight: size.width * 1.2),
                                  child: NotificationListener<
                                      UserScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification.direction ==
                                          ScrollDirection.forward) {
                                        if (!isBannerVisible) {
                                          setState(() {
                                            isBannerVisible = true;
                                          });
                                        }
                                        Get.appUpdate();
                                      } else if (notification.direction ==
                                          ScrollDirection.reverse) {
                                        if (isBannerVisible) {
                                          setState(() {
                                            isBannerVisible = false;
                                          });
                                        }
                                        Get.appUpdate();
                                      }
                                      return true;
                                    },
                                    child: ListView.builder(
                                        itemCount: widget.users!.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedUser =
                                                        widget.users![index];
                                                  });
                                                },
                                                child: TeacherTile(
                                                    widget.users![index],
                                                    selectedUser!)),
                                          );
                                        }),
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  opacity: selectedUser != null ? 1 : 0,
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 200,
                                    ),
                                    width: size.width * 0.65,
                                    height: selectedUser != null
                                        ? size.width * 0.12
                                        : 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedUser != null)
                                          widget.onCallback(selectedUser!);
                                      },
                                      child: Card(
                                        elevation: 4,
                                        color: AppColor.darkForegroundColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Container(
                                          width: size.width * 0.65,
                                          height: size.width * 0.12,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextStrokeWidget(
                                                    "Comfirm",
                                                    fontFamily: "Riffic",
                                                    color: Theme.of(context)
                                                        .secondaryHeaderColor,
                                                    fontSize:
                                                        size.width * 0.011,
                                                    strokeWidth: 0.2,
                                                    strokeColor: Colors.black,
                                                    overrideSizeStroke: true,
                                                    shadow: const [
                                                      Shadow(
                                                        blurRadius: 10,
                                                        offset: Offset(0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -8,
                        child: AnimatedOpacity(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          opacity: isBannerVisible ? 1 : 0,
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            width: size.width * 0.65,
                            height: isBannerVisible ? size.width * 0.12 : 0,
                            child: Card(
                              elevation: 4,
                              color: AppColor.darkForegroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              child: Container(
                                width: size.width * 0.65,
                                height: size.width * 0.11,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextStrokeWidget(
                                          "User List",
                                          fontFamily: "Riffic",
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontSize: size.width * 0.011,
                                          strokeWidth: 0.2,
                                          strokeColor: Colors.black,
                                          overrideSizeStroke: true,
                                          shadow: const [
                                            Shadow(
                                              blurRadius: 10,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TeacherTile(
    User user,
    User selectedUser,
  ) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Card(
      elevation: 12,
      margin: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.darkForegroundColor,
          border: Border.all(
            color: selectedUser == user
                ? white
                : theme.scaffoldBackgroundColor.withOpacity(0.6),
          ),
          gradient: selectedUser == user
              ? LinearGradient(
                  colors: const [
                    Color.fromRGBO(255, 148, 54, 1.0),
                    Color.fromRGBO(255, 170, 0, 1.0),
                    Color.fromRGBO(255, 189, 58, 1.0),
                  ],
                )
              : null,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.5, 0.5),
              color: selectedUser == user
                  ? theme.primaryColor
                  : white.withOpacity(0.6),
              blurRadius: 2,
            ),
            BoxShadow(
              offset: Offset(-0.5, -0.5),
              color: selectedUser == user
                  ? theme.primaryColor
                  : white.withOpacity(0.6),
              blurRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.000),
                child: AvatarTextFrame(
                    frameUrl: "assets/list_frame.png",
                    isTopThree: false,
                    width: size.width * 0.13,
                    user: user),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: context.isTablet
                        ? size.height * 0.15
                        : size.width * 0.25,
                    height: context.isTablet
                        ? size.height * 0.03
                        : size.width * 0.06,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: TextWidget(
                              "${user.name}",
                              fontFamily: "Riffic",
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: context.isTablet
                                  ? size.height * 0.022
                                  : size.width * 0.038,
                              strokeWidth: 3,
                              strokeColor: Colors.black,
                              overrideSizeStroke: true,
                              shadow: const [
                                Shadow(blurRadius: 10, offset: Offset(0, 3)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: context.isTablet
                        ? size.height * 0.15
                        : size.width * 0.25,
                    height: context.isTablet
                        ? size.height * 0.03
                        : size.width * 0.06,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: TextWidget(
                              CustomFormat.formatRmPrice(user.sales),
                              fontFamily: "Riffic",
                              color: AppColor.lightForegroundColor,
                              fontSize: context.isTablet
                                  ? size.height * 0.022
                                  : size.width * 0.038,
                              strokeWidth: 3,
                              strokeColor: Colors.black,
                              overrideSizeStroke: true,
                              shadow: const [
                                Shadow(blurRadius: 10, offset: Offset(0, 3)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

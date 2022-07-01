import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vimogo/models/levels.dart';
import 'package:vimogo/widgets/popup_menu.dart';

import '../configs/colors.dart';
import '../configs/custom_format.dart';
import '../widgets/level_tile.dart';
import '../models/users.dart';
import '../widgets/Avatar_Text_Frame.dart';
import '../widgets/app_push_button.dart';
import '../widgets/custom_scrollable_btm.dart';
import '../widgets/custom_scrollable_controller.dart';
import '../widgets/popup_user_selection.dart';
import '../widgets/square_icon_button.dart';
import '../widgets/text_stroke_widget.dart';
import '../widgets/text_widget.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  final ScrollController scrollController = ScrollController();
  double scrollValue = 1;
  double elevation = 1;
  bool isFull = false;
  User? selectedUser;
  ColorSwatch? _tempMainColor;
  Color? _tempShadeColor;
  ColorSwatch? _mainColor = Colors.orange;
  Color? _shadeColor = Color(0xfffbb040);
  final bottomSheetController = CustomScrollableController();

  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    scrollController.addListener(() {
      double value = scrollController.offset;
      if (scrollController.offset >= 187) {
        bottomSheetController.animateToFull(context);
      } else if (scrollController.offset <= 186) {
        bottomSheetController.animateToMinimum(context);
      }
      setState(() {
        scrollValue = value;
      });

      print(scrollValue);
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollBtn() {
    if (isFull) {
      bottomSheetController.animateToMinimum(context);
      isFull = false;
      setState(() {});
    } else if (!isFull) {
      bottomSheetController.animateToFull(context);

      isFull = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<User>? users = User.generateUser();

    List<Levels>? levels = Levels.generateLevels();
    users.sort(((a, b) {
      return a.sales.compareTo(b.sales);
    }));
    List<User>? ranking = users.reversed.toList();
    int myRanking = (selectedUser != null)
        ? ranking.indexWhere((element) => element.name == selectedUser!.name)
        : ranking.indexWhere((element) => element.name == "Aurora");

    User user = ranking[myRanking];
    int? myTier = Levels.getTier(user.sales);

    return Scaffold(
      backgroundColor: AppColor.lightBackgroundColor,
      body: Stack(
        children: [
          Container(
            height: size.height * 1,
            width: size.width * 1,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.11),
                  child: Container(
                    height: size.width * 0.13,
                    width: size.width * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.width * 0.085,
                          width: size.width * 0.08,
                        ),
                        SquareIconButton(
                          onPressed: () {},
                          color: _shadeColor,
                          icon: Icons.arrow_back_ios,
                        ),
                        const Spacer(),
                        Text(
                          "VIMISALES",
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: elevation),
                                Shadow(
                                    color: Colors.white.withOpacity(0.5),
                                    offset: Offset(-2.0, 2.0),
                                    blurRadius: elevation),
                              ]),
                        ),
                        const Spacer(),
                        PopUpMenu(
                          menuList: const [
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(
                                  CupertinoIcons.person,
                                ),
                                title: Text("My Profile"),
                              ),
                            ),
                            PopupMenuDivider(),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(
                                  CupertinoIcons.settings,
                                ),
                                title: Text("Settings"),
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(
                                  Icons.help_outline,
                                ),
                                title: Text("About Us"),
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(
                                  Icons.logout,
                                ),
                                title: Text("Log Out"),
                              ),
                            ),
                          ],
                          icon: Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                image: AssetImage(user.photoUrl),
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 0.0,
                                    blurRadius: elevation,
                                    offset: Offset(2.0, 2.0)),
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 0.0,
                                    blurRadius: elevation / 2.0,
                                    offset: Offset(2.0, 2.0)),
                                BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 2.0,
                                    blurRadius: elevation,
                                    offset: Offset(-2.0, -2.0)),
                                BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 2.0,
                                    blurRadius: elevation / 2,
                                    offset: Offset(-2.0, -2.0)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.width * 0.085,
                          width: size.width * 0.08,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.27),
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (_, v) => [
                SliverAppBar(
                  leading: Container(),
                  expandedHeight: size.width * 0.45,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: FlexibleSpaceBar(
                      stretchModes: const <StretchMode>[
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle,
                      ],
                      background: Container(
                        height: size.width * 2,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: size.width * 0.9,
                                  height: size.width * 0.5,
                                  decoration: const BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(0)),
                                      image: const DecorationImage(
                                        image: AssetImage("assets/card.png"),
                                        fit: BoxFit.contain,
                                      )),
                                ),
                                Container(
                                  width: size.width * 0.9,
                                  height: size.width * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${CustomFormat.firstDay(DateTime.now())} - ${CustomFormat.lastDay(DateTime.now())}",
                                              style: TextStyle(
                                                color: darkGrey,
                                                fontSize: size.width * 0.04,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.width * 0.03,
                                        ),
                                        Text(
                                          CustomFormat.formatRmPrice(
                                              user.sales),
                                          style: TextStyle(
                                            color: darkGrey,
                                            fontSize: size.width * 0.06,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Current Sales Achievement",
                                          style: TextStyle(
                                            color: darkGrey,
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              CustomFormat.formatRmPrice(
                                                  Levels.getCommission(
                                                      2550042)!),
                                              style: TextStyle(
                                                color: darkGrey,
                                                fontSize: size.width * 0.06,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Earned",
                                          style: TextStyle(
                                            color: darkGrey,
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: size.width * 0.09,
                                  bottom: size.width * 0.18,
                                  child: TextStrokeWidget(
                                    "#${myRanking + 1}",
                                    fontFamily: "Riffic",
                                    color: lightGrey,
                                    fontSize: size.width * 0.0125,
                                    strokeWidth: size.width * 0.0012,
                                    strokeColor: Colors.black,
                                    overrideSizeStroke: true,
                                    shadow: const [
                                      Shadow(
                                          blurRadius: 20,
                                          offset: Offset(0, 0.2)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(size.width * 0.0),
                    child: SizedBox(height: size.width * 0.0),
                  ),
                ),
              ],
              body: PreferredSize(
                preferredSize: Size.fromHeight(size.width * 0.2),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: levels.length,
                          itemBuilder: (context, index) {
                            return Align(
                              heightFactor: size.height * 0.0010859,
                              child: LevelTile(
                                level: levels[index],
                                newColor: _shadeColor!,
                                user: user,
                                isCurrent: levels[index].tier == myTier,
                                isFirst: index == 0,
                                isLast: index == levels.length - 1,
                                isDone: user.sales >= levels[index].target,
                                isOdd: index.isOdd,
                                isNextTarget: levels[index].tier == myTier! + 1,
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: size.width * 0.12)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomScrollableBtm(
              controller: bottomSheetController,
              minimumHeight: size.width * 0.1,
              halfHeight: size.height * 0.4,
              autoPop: false,
              firstScrollTo: ScrollState.minimum,
              mayExceedChildHeight: false,
              snapAbove: false,
              snapBelow: false,
              callback: (state) {
                if (state == ScrollState.minimum) {
                  isFull = false;
                  print(isFull);
                  print(state);
                } else if (state == ScrollState.full) {
                  isFull = true;
                  print(isFull);
                  print(state);
                }
              },
              child: Container(
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  color: AppColor.darkBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      topLeft: Radius.circular(24.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _scrollBtn,
                      child: Container(
                        color: Colors.transparent,
                        height: size.height * 0.04,
                        width: size.width * 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Center(
                            child: Container(
                              height: size.height * 0.008,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: _shadeColor!,
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24.0),
                                      topLeft: Radius.circular(24.0))),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(),
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColor.lightBackgroundColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                              )),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    AppPushButton(
                                                      mainColor: _shadeColor!,
                                                      text: 'Color Picker',
                                                      onTap: _openColorPicker,
                                                      fontSize:
                                                          size.width * 0.05,
                                                      width: size.width * 0.85,
                                                    ),
                                                    AppPushButton(
                                                      mainColor: _shadeColor!,
                                                      text: 'User Picker',
                                                      onTap: () {
                                                        Get.dialog(
                                                            PopUpUserSelection(
                                                          user: ranking[
                                                              myRanking],
                                                          users: ranking,
                                                          onCallback:
                                                              (element) {
                                                            setState(() {
                                                              selectedUser =
                                                                  element;
                                                            });
                                                            Get.back();
                                                            bottomSheetController
                                                                .animateToMinimum(
                                                                    context);
                                                          },
                                                        ));
                                                      },
                                                      fontSize:
                                                          size.width * 0.05,
                                                      width: size.width * 0.85,
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  width: size.width * 0.95,
                                                  height: size.width * 0.4,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      AvatarTextFrame(
                                                          frameUrl:
                                                              "assets/top2_frame.png",
                                                          isTopThree: true,
                                                          width:
                                                              size.width * 0.28,
                                                          user: ranking[1]),
                                                      AvatarTextFrame(
                                                          frameUrl:
                                                              "assets/top1_frame.png",
                                                          isTopThree: true,
                                                          width:
                                                              size.width * 0.35,
                                                          user: ranking[0]),
                                                      AvatarTextFrame(
                                                          frameUrl:
                                                              "assets/top3_frame.png",
                                                          isTopThree: true,
                                                          width:
                                                              size.width * 0.28,
                                                          user: ranking[2]),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            ranking.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.1,
                                                                height:
                                                                    size.width *
                                                                        0.06,
                                                                child:
                                                                    LayoutBuilder(
                                                                  builder: (context,
                                                                      constraints) {
                                                                    return Container(
                                                                      child:
                                                                          FittedBox(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            TextWidget(
                                                                          "${index + 1}",
                                                                          fontFamily:
                                                                              "Riffic",
                                                                          color:
                                                                              _shadeColor!,
                                                                          fontSize: context.isTablet
                                                                              ? size.height * 0.022
                                                                              : size.width * 0.038,
                                                                          strokeWidth:
                                                                              3,
                                                                          strokeColor:
                                                                              Colors.black,
                                                                          overrideSizeStroke:
                                                                              true,
                                                                          shadow: const [
                                                                            Shadow(
                                                                                blurRadius: 10,
                                                                                offset: Offset(0, 3)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: size
                                                                            .width *
                                                                        0.01),
                                                                child: AvatarTextFrame(
                                                                    frameUrl:
                                                                        "assets/list_frame.png",
                                                                    isTopThree:
                                                                        false,
                                                                    width: size
                                                                            .width *
                                                                        0.13,
                                                                    user: ranking[
                                                                        index]),
                                                              ),
                                                              SizedBox(
                                                                width: 12,
                                                              ),
                                                              SizedBox(
                                                                width: context
                                                                        .isTablet
                                                                    ? size.height *
                                                                        0.15
                                                                    : size.width *
                                                                        0.25,
                                                                height: context
                                                                        .isTablet
                                                                    ? size.height *
                                                                        0.03
                                                                    : size.width *
                                                                        0.06,
                                                                child:
                                                                    LayoutBuilder(
                                                                  builder: (context,
                                                                      constraints) {
                                                                    return Container(
                                                                      child:
                                                                          FittedBox(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            TextWidget(
                                                                          "${ranking[index].name}",
                                                                          fontFamily:
                                                                              "Riffic",
                                                                          color:
                                                                              _shadeColor!,
                                                                          fontSize: context.isTablet
                                                                              ? size.height * 0.022
                                                                              : size.width * 0.038,
                                                                          strokeWidth:
                                                                              3,
                                                                          strokeColor:
                                                                              Colors.black,
                                                                          overrideSizeStroke:
                                                                              true,
                                                                          shadow: const [
                                                                            Shadow(
                                                                                blurRadius: 10,
                                                                                offset: Offset(0, 3)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: size
                                                                            .width *
                                                                        0.03),
                                                                child: SizedBox(
                                                                  width: context
                                                                          .isTablet
                                                                      ? size.height *
                                                                          0.15
                                                                      : size.width *
                                                                          0.25,
                                                                  height: context
                                                                          .isTablet
                                                                      ? size.height *
                                                                          0.03
                                                                      : size.width *
                                                                          0.06,
                                                                  child:
                                                                      LayoutBuilder(
                                                                    builder:
                                                                        (context,
                                                                            constraints) {
                                                                      return Container(
                                                                        child:
                                                                            FittedBox(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              TextWidget(
                                                                            CustomFormat.formatRmPrice(ranking[index].sales),
                                                                            fontFamily:
                                                                                "Riffic",
                                                                            color:
                                                                                _shadeColor!,
                                                                            fontSize: context.isTablet
                                                                                ? size.height * 0.022
                                                                                : size.width * 0.038,
                                                                            strokeWidth:
                                                                                3,
                                                                            strokeColor:
                                                                                Colors.black,
                                                                            overrideSizeStroke:
                                                                                true,
                                                                            shadow: const [
                                                                              Shadow(blurRadius: 10, offset: Offset(0, 3)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }))
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            AppPushButton(
              mainColor: _shadeColor!,
              text: 'CANCEL',
              onTap: Navigator.of(context).pop,
              fontSize: size.width * 0.04,
              width: size.width * 0.6,
            ),
            AppPushButton(
              mainColor: _shadeColor!,
              text: 'SUBMIT',
              onTap: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
              fontSize: size.width * 0.04,
              width: size.width * 0.6,
            )
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Color picker",
      MaterialColorPicker(
        selectedColor: _shadeColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        onBack: () => print("Back button pressed"),
      ),
    );
  }
}

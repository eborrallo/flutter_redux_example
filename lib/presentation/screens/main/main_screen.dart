import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_redux_boilerplate/config/screens.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/CalendarNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/ClassNotifier.dart';

import 'package:flutter_redux_boilerplate/presentation/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_drawer.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_tabs/calendar_tab.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_tabs/home_tab.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_tabs/profile_tab.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_tabs/task_tab.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/fab_with_icons.dart';
import 'dart:math';

import 'package:flutter_redux_boilerplate/presentation/widgets/layout.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<InOutAnimationState> inOutAnimation =
      GlobalKey<InOutAnimationState>();
  PageController _tabController;
  AnimationController _controller;
  Widget appbarTitle;
  Icon appbarActionIcon;
  int _index;

  Animatable<Color> background = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.blue,
          end: Colors.purple,
        ),
      ),
    ],
  );
  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    this._index = 0;
    appbarTitle = Text(
      TabItems[this._index].text,
      style: TextStyle(color: Colors.black),
    );
    appbarActionIcon = Icon(Icons.search);
  }

  Widget _buildFab(BuildContext context) {
    final icons = [
      Icons.assignment,
      Icons.assignment_ind,
      Icons.assignment_turned_in
    ];

    return AnchoredOverlay(
        showOverlay: true,
        overlayBuilder: (context, offset) {
          return CenterAbout(
            position: Offset(offset.dx, offset.dy - icons.length * 35.0),
            child: FabWithIcons(
              icons: icons,
              onIconTapped: (int i) {
                switch (i) {
                  case 0:
                    getIt<NavigationService>().navigateToNext(
                        ADD_SUBJECT_SCREEN,
                        pageTransition: PageTransitionType.bottomToTop);

                    break;
                  case 1:
                    getIt<NavigationService>().navigateToNext(
                        ADD_LECTURER_SCREEN,
                        pageTransition: PageTransitionType.bottomToTop);
                    break;

                  case 2:
                    getIt<NavigationService>().navigateToNext(ADD_TASK_SCREEN,
                        pageTransition: PageTransitionType.bottomToTop);

                    break;
                  default:
                    break;
                }
              },
              controller: _controller,
            ),
          );
        },
        child: InOutAnimation(
          key: inOutAnimation,
          inDefinition: ZoomInAnimation(),
          outDefinition: ZoomOutAnimation(),
          child: new AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return new FloatingActionButton(
                onPressed: () {
                  if (_controller.isDismissed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                backgroundColor: background
                    .evaluate(AlwaysStoppedAnimation(_controller.value)),
                child: new Transform(
                    transform:
                        new Matrix4.rotationZ(_controller.value * 0.25 * pi),
                    alignment: FractionalOffset.center,
                    child: new Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    )),
                elevation: 0,
              );
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<AppNotifier>(context, listen: true);
    final classNotifier = Provider.of<ClassNotifier>(context, listen: true);
    final calendarNotifier =
        Provider.of<CalendarNotifier>(context, listen: true);
    final taskNotifier = Provider.of<TaskNotifier>(context, listen: true);

    // final subjectNotifier = Provider.of<SubjectNotifier>(context, listen: true);

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new PlatformAdaptiveAppBar(
        actions: (this._index == 1
            ? [
                IconButton(
                  icon: appbarActionIcon,
                  onPressed: () {
                    setState(() {
                      if (this.appbarActionIcon.icon == Icons.search) {
                        this.appbarTitle = TextFormField(
                          textAlign: TextAlign.center,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Search your task'),
                        );
                        this.appbarActionIcon = Icon(Icons.cancel);
                      } else {
                        this.appbarTitle = Text(
                          TabItems[this._index].text,
                          style: TextStyle(color: Colors.black),
                        );
                        this.appbarActionIcon = Icon(Icons.search);
                      }
                    });
                  },
                )
              ]
            : [])
          ..addAll([
            Container(
              width: 60,
              height: 60,
              padding: EdgeInsets.only(right: 21),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('AH'),
              ),
            )
          ]),
        title: appbarTitle,
        platform: Theme.of(context).platform,
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            _controller.reverse();
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
          color: Colors.grey,
          selectedColor: Colors.blue,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: onTap,
          items: TabItems),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
      body: new PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          new HomeTab(
            appNotifier: appNotifier,
          ),
          new TaskTab(taskNotifier: taskNotifier),
          new CalendarTab(
            appNotifier: appNotifier,
          ),
          new ProfileTab(
            appNotifier: appNotifier,
          ),
        ],
      ),
      drawer: new MainDrawer(),
    );
  }

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    _controller.reverse();
    setState(() {
      this._index = tab;
      appbarTitle = new Text(
        TabItems[tab].text,
        style: TextStyle(color: Colors.black),
      );
    });
  }
}

List<FABBottomAppBarItem> TabItems = <FABBottomAppBarItem>[
  FABBottomAppBarItem(text: 'Home', iconData: Icons.home),
  FABBottomAppBarItem(
    text: 'Task',
    iconData: Icons.work,
  ),
  FABBottomAppBarItem(text: 'Calendar', iconData: Icons.calendar_today),
  FABBottomAppBarItem(text: 'Profile', iconData: Icons.person),
];

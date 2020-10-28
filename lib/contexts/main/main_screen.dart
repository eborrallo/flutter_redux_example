import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/contexts/main/fab_bottom_app_bar.dart';
import 'package:flutter_redux_boilerplate/contexts/main/fab_with_icons.dart';
import 'package:flutter_redux_boilerplate/contexts/main/layout.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_drawer.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_tabs/discover_tab.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_tabs/news_tab.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_tabs/stats_tab.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _tabController;
  String _title;
  int _index;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    _title = TabItems[0].text;
    _index = 0;
  }


  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (int) {},
          ),
        );
      },
      child:  FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.add,
            color: Colors.transparent,
          ),
          elevation: 0,
        ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: new PlatformAdaptiveAppBar(
        title: new Text(
          _title,
          style: TextStyle(color: Colors.black),
        ),
        platform: Theme.of(context).platform,
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
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
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          new NewsTab(),
          new StatsTab(),
          new DiscoverTab(),
          new DiscoverTab(),
          new DiscoverTab(),
        ],
      ),
      drawer: new MainDrawer(),
    );
  }

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._index = tab;
    });

    this._title = TabItems[tab].text;
  }
}

List<FABBottomAppBarItem> TabItems = <FABBottomAppBarItem>[
  FABBottomAppBarItem(text: 'Home', iconData: Icons.home),
  FABBottomAppBarItem(text: 'Task', iconData: Icons.work),
  FABBottomAppBarItem(text: 'Calendar', iconData: Icons.calendar_today),
  FABBottomAppBarItem(text: 'Profile', iconData: Icons.person),
];

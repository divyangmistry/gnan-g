import 'package:GnanG/UI/leaderboards/leaderboard.dart';
import 'package:GnanG/UI/leaderboards/leaderboard_monthly.dart';
import 'package:GnanG/UI/leaderboards/leaderboard_weekly.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/leaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import "package:GnanG/fancy_bottom_navigation.dart";

 
class TabLeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyTabbedPage(),
    );
    // return new MaterialApp(
    //     theme: ThemeData(primaryColor: Colors.pink,
    //     brightness: Brightness.light),
    //     home: Scaffold(
    //         body: Center(),
    //         bottomNavigationBar: child));
  }
}


class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}
class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    //new Tab(text: 'Weekly',icon: Icon(Icons.weekend)),
    new Tab(text: 'Monthly',icon: Icon(Icons.access_time)),
    new Tab(text: 'World',icon: Icon(Icons.account_balance)),
  ];

  List<Leaders> leaderList;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    //_tabController.addListener(_handleTabSelection);
  }
 void _handleTabSelection() async {
   // setState(() {
      try{
        // Tab ta= myTabs[_tabController.index];
        // Widget wedget = await _loadLeadersAndRank();

        // myTabs[_tabController.index]=new Tab(text:"2123",icon: Icon(Icons.directions_car), child: wedget);
        print("tab Index Call:" + _tabController.index.toString());
      } catch (err) {
        print(err);
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
    //});
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
 int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      // appBar: new AppBar(
      //   elevation: 0.0,
      //   actions: <Widget>[ Container(
      //           padding: EdgeInsets.only(bottom: 5.0),
      //           margin: EdgeInsets.only(top: 10.0),)], 

      //   bottom: new TabBar(
      //     controller: _tabController,
      //     tabs: myTabs, 
      //   ),
      // ),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   title: Text(_getTitleForCurrentTab(_Tab.values[_currentTabIndex])), // set the title in the AppBar
        
      // ),
      body: new TabBarView(
        controller: _tabController,
        children:  [
              //WeeklyLeaderBoard(),
              MonthlyLeaderBoard(),
              LeaderBoard(),
            ],
      ),
      bottomNavigationBar: TabBar(
         controller: _tabController,
        tabs: myTabs,
        
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.red,
      ),
    //  bottomNavigationBar: BottomAppBar(
    //   shape: CircularNotchedRectangle(),
    //   notchMargin: 4.0,
    //   child: new Row(
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       IconButton(icon: Icon(Icons.menu),  onPressed: () {WeeklyLeaderBoard();}),
    //       IconButton(icon: Icon(Icons.search), onPressed: () {MonthlyLeaderBoard();},),
    //       IconButton(icon: Icon(Icons.search), onPressed: () {new Icon(Icons.directions_bike);},),
    //     ],
    //   ),
    // ), 
      // bottomNavigationBar: BottomNavigationBar(
        
      //   onTap: (int index) {
      //     // when a tab icon was tapped we just change the current index of the tab with the new one
      //     // this set state call will re-render the screen and will set new the tab as active
      //     setState(() {
      //       _currentTabIndex = index;
      //     });

      //     // also we want to change the screen content not just the active tab icon
      //     // so we use the TabController to go to another tab giving it the index of the tab which was just clicked
      //     _tabController.animateTo(index);
      //   },
      //   // here we render all the icons we want in the BottomNavigationBar
      //   // we get all the values of the _Tab enum and for each one we render a BottomNavigationBarItem
      //   items: _Tab.values
      //       .map((_Tab tab) => BottomNavigationBarItem(
      //           title: Text(_getTitleForCurrentTab(tab)), // set the title of the tab icon
      //           icon: _getAssetForTab(tab)
      //           )) // set the icon of the tab
      //       .toList(),
      // )
    );
  }

AnimationController _animationController;
  Tween<double> _positionTween;
  Animation<double> _positionAnimation;

  AnimationController _fadeOutController;
  Animation<double> _fadeFabOutAnimation;
  Animation<double> _fadeFabInAnimation;

  double fabIconAlpha = 1;
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;
  
  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }
  /// Get the asset icon for the given tab
  Icon _getAssetForTab(_Tab tab) {
    // check if the given tab parameter is the current active tab
    final active = tab == _Tab.values[_currentTabIndex];

    // now given the tab param get its icon considering the fact that if it is active or not
    // if (tab == _Tab.TAB1) {
    //   return active ? 'images/bkg.png' : 'images/face.png';
    // } else if (tab == _Tab.TAB2) {
    //   return active ? 'images/coin.png' : 'images/face.png';
    // }
    return active ? Icon(Icons.directions_bike) : Icon(Icons.accessibility);
  }
  /// Get the title for the current selected tab
  String _getTitleForCurrentTab(_Tab tab) {
    if (tab == _Tab.TAB1) {
      return 'Weekly';
    } else if (tab == _Tab.TAB2) {
      return 'Monthly';
    }
    return 'World';
  }
}
enum _Tab {
  TAB1,
  TAB2,
  TAB3,
}
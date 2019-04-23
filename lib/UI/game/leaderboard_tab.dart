import 'package:GnanG/UI/leaderboard.dart';
import 'package:GnanG/UI/leaderboards/leaderboard_monthly.dart';
import 'package:GnanG/UI/leaderboards/leaderboard_weekly.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
            title: Text(title),
            backgroundColor: color),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(int index, BuildContext context) {
    Color iconColor = _color;

    print('Current Index');
    print(index);

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: buildLeaderBoard(index, iconColor),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget build_users_row(String name, String rank, iconColor, String points) {
  return ListTile(
    title: Text(name),
    trailing: Text(rank, textAlign: TextAlign.right,textScaleFactor: 1.5,),
    leading: CircleAvatar(
      child: Icon(Icons.account_circle),
      backgroundColor: iconColor,
    ),
    subtitle: Text('Points : ' + points),
  );
}

buildLeaderBoard(int index, iconColor) {
  if (index == 0) {
    return WeeklyLeaderBoard();
//    return ListView(
//      children: <Widget>[
//        build_users_row('Milan Vadher', '20', iconColor, '500'),
//        Divider(),
//        build_users_row('Divyang Mistry', '11', iconColor, '400'),
//        Divider(),
//        build_users_row('Gaurav Suri', '52', iconColor, '300'),
//        Divider(),
//        build_users_row('Rohit Baheti', '64', iconColor, '200'),
//        Divider(),
//        build_users_row('Milan Vadher', '20', iconColor, '500'),
//        Divider(),
//        build_users_row('Divyang Mistry', '11', iconColor, '400'),
//        Divider(),
//        build_users_row('Gaurav Suri', '52', iconColor, '300'),
//        Divider(),
//        build_users_row('Rohit Baheti', '64', iconColor, '200'),
//        Divider(),
//        build_users_row('Divyang Mistry', '11', iconColor, '400'),
//        Divider(),
//        build_users_row('Gaurav Suri', '52', iconColor, '300'),
//        Divider(),
//        build_users_row('Rohit Baheti', '64', iconColor, '200'),
//        Divider()
//      ],
//    );
  }
  if (index == 1) {
    return MonthlyLeaderBoard();
//    return ListView(
//      children: <Widget>[
//        build_users_row('Rohit Baheti', '1', iconColor, '60'),
//        Divider(),
//        build_users_row('Gaurav Suri', '2', iconColor, '40'),
//        Divider(),
//        build_users_row('Milan Vadher', '3', iconColor, '30'),
//        Divider(),
//        build_users_row('Divyang Mistry', '4', iconColor, '10'),
//        Divider(),
//      ],
//    );
  }
  if (index == 2) {
    return LeaderBoard();
//    return ListView(
//      children: <Widget>[
//        build_users_row('Divyang Mistry', '222', iconColor, '4000'),
//        Divider(),
//        build_users_row('Milan Vadher', '555', iconColor, '3540'),
//        Divider(),
//        build_users_row('Gaurav Suri', '999', iconColor, '2412'),
//        Divider(),
//        build_users_row('Rohit Baheti', '1000', iconColor, '2354'),
//        Divider()
//      ],
//    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: BoxDecoration(
          border: Border.all(color: iconTheme.color, width: 2.0),
        ));
  }
}

class Rank extends StatelessWidget {
  Rank({Key key, this.rank: 0}) : super(key: key);

  final int rank;

  Widget build(BuildContext context) {
    return Text(
      rank.toString(),
      textScaleFactor: 1,
      style: TextStyle(fontSize: 32, color: Colors.white),
    );
  }
}

class BottomNavigationDemo extends StatefulWidget {
  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with TickerProviderStateMixin {
  int _currentIndex = 1;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.weekend),
        title: 'Weekly',
        color: Colors.deepPurple,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.access_time),
        icon: const Icon(Icons.access_time),
        title: 'Monthly',
        color: kQuizMain400,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.favorite),
        icon: const Icon(Icons.account_balance),
        title: 'World',
        color: Colors.indigo,
        vsync: this,
      ),
    ];

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  Widget _buildTransitionsStack(index) {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(index, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>(
              (NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      body: _buildTransitionsStack(_currentIndex),
      bottomNavigationBar: botNavBar,
    );
  }
}

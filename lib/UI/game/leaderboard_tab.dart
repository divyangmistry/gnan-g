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
          backgroundColor: color
        ),
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
        child: buildLeaderBoard(index),
      ),
    );
  }
}

buildLeaderBoard(int index) {
  if (index == 0) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Milan Vadher'),
          leading: CircleAvatar(child: Icon(Icons.account_circle),),
          subtitle: Text('Points : 500'),
        ),
        Divider(),
        ListTile(
          title: Text('Divyang Mistry'),
          leading: CircleAvatar(child: Icon(Icons.account_circle),),
          subtitle: Text('Points : 400'),
        ),
        Divider(),
        ListTile(
          title: Text('Gaurav Suri'),
          leading: CircleAvatar(child: Icon(Icons.account_circle),),
          subtitle: Text('Points : 300'),
        ),
        Divider(),
        ListTile(
          title: Text('Rohit Baheti'),
          leading: CircleAvatar(child: Icon(Icons.account_circle),),
          subtitle: Text('Points : 200'),
        ),
        Divider()
      ],
    );
  }
  if (index == 1) {
    return Text('Day wise Leaderboard', textScaleFactor: 2,);
  }
  if (index == 2) {
    return Text('Year wise Leaderboard', textScaleFactor: 2,);
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
        icon: const Icon(Icons.all_inclusive),
        title: 'Month',
        color: Colors.deepPurple,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.today),
        icon: const Icon(Icons.calendar_today),
        title: 'Day',
        color: kQuizMain400,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.favorite),
        icon: const Icon(Icons.favorite_border),
        title: 'Year',
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
      appBar: AppBar(
        title: const Text('Bottom navigation'),
      ),
      body: Center(child: _buildTransitionsStack(_currentIndex)),
      bottomNavigationBar: botNavBar,
    );
  }
}

//import 'dart:math';
//
//import 'package:GnanG/UI/others/feedback.dart';
//import 'package:GnanG/colors.dart';
//import 'package:GnanG/utils/app_setting_util.dart';
//import 'package:GnanG/utils/appsharedpref.dart';
//import 'package:flutter/material.dart';
//import 'package:vector_math/vector_math.dart' as radians;
//import 'package:GnanG/common.dart';
//import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//
//class FabAnimatedButton extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return FabAnimatedButtonState();
//  }
//}
//
//class FabAnimatedButtonState extends State<FabAnimatedButton>
//    with SingleTickerProviderStateMixin {
//  AnimationController controller;
//  bool isMuteEnabled = false;
//
//  @override
//  void initState() {
//    super.initState();
//    controller = AnimationController(
//      duration: Duration(
//        milliseconds: 500,
//      ),
//      vsync: this,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    // return RadialAnimation(
//    //   controller: controller,
//    // );
//    return speedDialButton();
//  }
//
//  speedDialButton() {
//    return SpeedDial(
//      animatedIcon: AnimatedIcons.menu_close,
//      animatedIconTheme: IconThemeData(size: 22.0),
//      visible: true,
//      curve: Curves.bounceIn,
//      overlayColor: Colors.black,
//      overlayOpacity: 0.5,
//      onOpen: () => print('OPENING DIAL'),
//      onClose: () => print('DIAL CLOSED'),
//      tooltip: 'Speed Dial',
//      heroTag: 'speed-dial-hero-tag',
//      backgroundColor: Colors.white,
//      foregroundColor: Colors.black,
//      elevation: 8.0,
//      shape: CircleBorder(),
//      children: [
//        SpeedDialChild(
//            child: Icon(Icons.feedback),
//            label: 'Feedback',
//            backgroundColor: Colors.red,
//            labelStyle: TextStyle(fontSize: 18.0),
//            onTap: () {
//              Navigator.pushNamed(context, '/feedback');
//            }),
//        SpeedDialChild(
//          child: Icon(Icons.info_outline),
//          backgroundColor: Colors.blue,
//          label: 'About',
//          labelStyle: TextStyle(fontSize: 18.0),
//          onTap: () => showPikacharAboutDialog(context),
//        ),
//        SpeedDialChild(
//          child: _buildMuteIcon(),
//          backgroundColor: Colors.green,
//          label: 'Sound',
//          labelStyle: TextStyle(fontSize: 18.0),
//          onTap: () => toggleMuteSound,
//        ),
//      ],
//    );
//  }
//
//  Widget _buildMuteIcon() {
//    AppSharedPrefUtil.isMuteEnabled().then((isMute) {
//      setState(() {
//        isMuteEnabled = isMute;
//      });
//    });
//    return IconButton(
//      icon: Icon(
//        isMuteEnabled ? Icons.volume_off : Icons.volume_up,
//        color: kQuizSurfaceWhite,
//      ),
//      onPressed: toggleMuteSound,
//    );
//  }
//
//  void toggleMuteSound() async {
//    await AppSharedPrefUtil.saveMuteEnabled(
//        !await AppSharedPrefUtil.isMuteEnabled());
//    AppSharedPrefUtil.isMuteEnabled().then((isMute) {
//      setState(() {
//        isMuteEnabled = isMute;
//        if (!isMuteEnabled)
//          AppSetting.startBackgroundMusic();
//        else
//          AppSetting.stopBackgroundMusic();
//      });
//    });
//  }
//}
//
//// class RadialAnimation extends StatelessWidget {
////   RadialAnimation({Key key, this.controller})
////       : scale = Tween<double>(begin: 1.0, end: 0.0).animate(
////             CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
////         translation = Tween<double>(begin: 0.0, end: 100.0).animate(
////             CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
////         rotaton = Tween<double>(begin: 0.0, end: 360.0).animate(CurvedAnimation(
////             parent: controller,
////             curve: Interval(0.0, 0.7, curve: Curves.decelerate))),
////         super(key: key);
////   final AnimationController controller;
////   final Animation<double> scale;
////   final Animation<double> translation;
////   final Animation<double> rotaton;
//
////   @override
////   Widget build(BuildContext context) {
////     // TODO: implement build
////     return AnimatedBuilder(
////       animation: controller,
////       builder: (BuildContext context, Widget child) {
////         return Transform.rotate(
////           angle: radians.radians(rotaton.value),
////           child: Stack(
////             children: <Widget>[
////               // Stack(
////               //   children: <Widget>[
////               //     _buildButton(
////               //       1,
////               //       0,
////               //       color: Colors.blue.shade100,
////               //       icon: Icon(Icons.star_half, color: kQuizBrown900),
////               //     ),
////               //     _buildButton(
////               //       3,
////               //       -90,
////               //       color: Colors.blue.shade100,
////               //       icon: Icon(Icons.help, color: kQuizBrown900),
////               //     ),
////               //     _buildButton(
////               //       2,
////               //       180,
////               //       color: Colors.blue.shade100,
////               //       icon: Icon(Icons.call, color: kQuizBrown900),
////               //     ),
////               //   ],
////               // ),
////               Stack(
////                 children: <Widget>[
////                   _buildButton(
////                     1,
////                     0,
////                     color: Colors.blue.shade100,
////                     icon: Icon(Icons.star_half, color: kQuizBrown900),
////                   ),
////                   Transform.scale(
////                     scale: scale.value - 1.0,
////                     child: FloatingActionButton(
////                       child: Icon(Icons.close),
////                       onPressed: _close,
////                       backgroundColor: Colors.red,
////                       heroTag: 4,
////                     ),
////                   ),
////                   Transform.scale(
////                     scale: scale.value,
////                     child: FloatingActionButton(
////                       child: Icon(Icons.build),
////                       onPressed: _open,
////                       backgroundColor: kQuizBrown900,
////                       heroTag: 5,
////                     ),
////                   ),
////                 ],
////               ),
////             ],
////           ),
////         );
////       },
////     );
////   }
//
////   _buildButton(int index, double angle, {Color color, Icon icon}) {
////     final double rad = radians.radians(angle);
////     return Transform(
////         transform: Matrix4.identity()
////           ..translate(
////               (translation.value) * cos(rad), (translation.value) * sin(rad)),
////         child: MaterialButton(
////           child: icon,
////           color: color,
////           onPressed: () {
////             print('index is here !!!');
////           },
////         )
////         // FloatingActionButton(
////         //   child: icon,
////         //   tooltip: 'Click Here',
////         //   backgroundColor: color,
////         //   elevation: 2,
////         //   onPressed: () {
////         //     print(index);
////         //   },
////         //   heroTag: index,
////         // ),
////         );
////   }
//
////   _open() {
////     controller.forward();
////   }
//
////   _close() {
////     controller.reverse();
////   }
//// }
//
//void showPikacharAboutDialog(BuildContext context) {
//  final ThemeData themeData = Theme.of(context);
//  final TextStyle aboutTextStyle = themeData.textTheme.body2;
//
//  showAboutDialog(
//    context: context,
//    applicationVersion: 'v1.0.0',
//    applicationIcon: Image.asset(
//      "images/logo1.png",
//      height: 70,
//    ),
//    applicationLegalese: '© 2019 DBF',
////    children: <Widget>[
////      Padding(
////        padding: const EdgeInsets.only(top: 24.0),
////        child: RichText(
////          text: TextSpan(
////            children: <TextSpan>[
////              TextSpan(
////                style: aboutTextStyle,
////                text: 'Flutter is an early-stage, open-source project to help developers '
////                  'build high-performance, high-fidelity, mobile apps for '
////                  'iOS and Android '
////                  'from a single codebase. This gallery is a preview of '
////                  "Flutter's many widgets, behaviors, animations, layouts, "
////                  'and more. Learn more about Flutter'
////              ),
////              TextSpan(
////                style: aboutTextStyle,
////                text: '.',
////              ),
////            ],
////          ),
////        ),
////      ),
////    ],
//  );
//}
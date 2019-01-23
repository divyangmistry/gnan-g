import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class InroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new InroPageState();
}

class InroPageState extends State<InroPage> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "ERASER",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/logo1.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "PENCIL",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        pathImage: "images/TZLogo.jpg",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "images/face.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new IntroSlider(
        slides: this.slides,
        onDonePress: () {
          Navigator.pushReplacementNamed(context, '/login_new');
        },
        onSkipPress: () {
          Navigator.pushReplacementNamed(context, '/login_new');
        },
      ),
    );
  }
}

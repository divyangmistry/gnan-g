import 'package:GnanG/colors.dart';
import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  Image image;
  double maxRadius;
  Color backgroundColor;
  String heroTag;
  HeroImage({@required this.image, this.maxRadius = 45, this.backgroundColor = kQuizMain50, this.heroTag= "heroimage.png" });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(tag: heroTag, child: CircleAvatar(
        maxRadius: maxRadius,
        backgroundImage: image != null ? image.image : null,
        backgroundColor: backgroundColor,
      )),
      onTap: () {
        _onProfileImageClick(context);
      },
    );
  }

  void _onProfileImageClick(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => Scaffold(
          body: Center(
            child: Hero(
              tag: heroTag,
              child: image,
            ),
          ),
          backgroundColor: kQuizMain400,
        ),
        )
    );
  }
}

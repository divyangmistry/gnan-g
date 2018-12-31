import 'package:flutter/material.dart';

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  const DragBox({this.initPos, this.label, this.itemColor});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DragBoxState();
  }
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: widget.itemColor,
        child: new MaterialButton(
          color: widget.itemColor,
          child: new Text(
            widget.label,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        feedback: new MaterialButton(
          color: widget.itemColor,
          child: new Text(
            widget.label,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

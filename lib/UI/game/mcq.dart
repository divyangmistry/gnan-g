import 'package:GnanG/colors.dart';
import 'package:GnanG/model/question.dart';
import 'package:flutter/material.dart';

class MCQ extends StatefulWidget {
  final Question question;
  final Function validateAnswer;
  final List<int> hiddenOptionIndex;
  MCQ(this.question, this.validateAnswer, this.hiddenOptionIndex);

  @override
  MCQState createState() {
    return new MCQState();
  }
}

class MCQState extends State<MCQ> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          alignment: Alignment(0, -0.30),
          child: Text(
            ((widget.question != null) ? widget.question.question : ''),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Gujarati',
              color: kQuizMain400,
              height: 1.5,
            ),
            textScaleFactor: 2,
          ),
        ),
        new Container(
          padding: EdgeInsets.fromLTRB(50, 30, 50, 50),
          child: _buildOptions(),
        )
      ],
    );
  }

  Widget _buildOptions() {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        mainAxisSize: MainAxisSize.min,
        children: _getOptionsWidget(),
      ),
    );
  }

  List<Widget> _getOptionsWidget() {
    List<Widget> list = [];
    int i = 0;
    widget.question.options.forEach((option) {
      if (option != null) {
        list.add(new SizedBox(height: 20));
        list.add(_getOptionWidget(option.option, i++));
      }
    });
    return list;
  }

  Widget _getOptionWidget(String text, index) {
    return new SizedBox(
      width: double.infinity,
      child: !widget.hiddenOptionIndex.contains(index)
          ? new MaterialButton(
        elevation: 5,
        onPressed: () {
          setState(() {
            selectedIndex = index;
            widget.validateAnswer(answer: text);
          });
          setState(() {
            selectedIndex = -1;
          });
        },
        height: 50,
        child: Row(
          children: <Widget>[
            selectedIndex == index
                ? new Container(
              width: 0,
              child: Icon(
                Icons.check_circle,
                size: 25,
                color: kQuizMain500,
              ),
            )
                : new Container(),
            Expanded(
              child: Text(
                text,
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontFamily: 'Gujarati',
                  color:
                  selectedIndex == index ? kQuizBackgroundWhite : kQuizBackgroundWhite,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        color: selectedIndex == index ? kQuizMain400 : kQuizMain500,
      )
          : new Container(
        height: 50,
      ),
    );
  }
}
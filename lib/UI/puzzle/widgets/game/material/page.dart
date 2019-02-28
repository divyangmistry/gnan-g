import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:GnanG/UI/puzzle/widgets/game/board.dart';
import 'package:GnanG/UI/puzzle/widgets/game/material/control.dart';
import 'package:GnanG/UI/puzzle/widgets/game/material/sheets.dart';
import 'package:GnanG/UI/puzzle/widgets/game/material/steps.dart';
import 'package:GnanG/UI/puzzle/widgets/game/material/stopwatch.dart';
import 'package:GnanG/UI/puzzle/widgets/game/presenter/main.dart';
import 'package:GnanG/UI/puzzle/widgets/icons/app.dart';
import 'package:GnanG/common.dart';

class GameMaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = GamePresenterWidget.of(context);

    final screenSize = MediaQuery.of(context).size;
    final screenWidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? screenSize.width
            : screenSize.height;
    final screenHeight =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? screenSize.height
            : screenSize.width;

    final isTallScreen = screenHeight / screenWidth > 1.9;
    final isLargeScreen = screenWidth > 400;

    final fabWidget = _buildFab(context);
    final boardWidget = _buildBoard(context);
    return BackgroundGredient(
      child: WillPopScope(
        onWillPop: () {
          CommonFunction.alertDialog(
            msg: 'You will not get LIFE if you leave this PUZZLE !',
            title: 'Do you Really want to go back ?',
            context: context,
            doneButtonText: 'Yes',
            doneButtonFn: () {
              Navigator.pop(context);
            },
          );
        },
        child: OrientationBuilder(builder: (context, orientation) {
          final statusWidget = Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GameStopwatchWidget(
                time: presenter.time,
                fontSize: orientation == Orientation.landscape && !isLargeScreen
                    ? 56.0
                    : 72.0,
              ),
              // GameStepsWidget(
              //   steps: presenter.steps,
              // ),
            ],
          );

          if (orientation == Orientation.portrait) {
            //
            // Portrait layout
            //
            return Scaffold(
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Solve this PUZZLE to get LIFE !',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Expanded(
                      child: Center(
                        child: statusWidget,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    boardWidget,
                    isLargeScreen && isTallScreen
                        ? const SizedBox(height: 116.0)
                        : const SizedBox(height: 72.0),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: fabWidget,
            );
          } else {
            //
            // Landscape layout
            //
            return Scaffold(
              body: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    boardWidget,
                    statusWidget,
                  ],
                ),
              ),
              floatingActionButton: fabWidget,
            );
          }
        }),
      ),
    );
  }

  Widget _buildBoard(final BuildContext context) {
    final presenter = GamePresenterWidget.of(context);
    final background = Theme.of(context).brightness == Brightness.dark
        ? Colors.black54
        : Colors.black12;
    return Center(
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final puzzleSize = min(
              constraints.maxWidth,
              constraints.maxHeight,
            );

            return BoardWidget(
              board: presenter.board,
              size: puzzleSize,
              onTap: (point) {
                presenter.tap(point: point);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFab(final BuildContext context) {
    final presenter = GamePresenterWidget.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // const SizedBox(width: 64.0),
        Container(
          alignment: Alignment.bottomCenter,
          child: GamePlayStopButton(
            isPlaying: presenter.isPlaying(),
            onTap: () {
              presenter.playStop();
            },
          ),
        )
        // const SizedBox(width: 16.0),
        // Container(
        //   width: 48,
        //   height: 48,
        //   child: Material(
        //     elevation: 0.0,
        //     color: Colors.transparent,
        //     shape: CircleBorder(),
        //     child: InkWell(
        //       onTap: () {
        //         // Show the modal bottom sheet on
        //         // tap on "More" icon.
        //         showModalBottomSheet<void>(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return createMoreBottomSheet(context,
        //                 psize: presenter.board.size, call: (size) {
        //               presenter.resize(size);
        //             });
        //           },
        //         );
        //       },
        //       customBorder: CircleBorder(),
        //       child: Icon(Icons.more_vert),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

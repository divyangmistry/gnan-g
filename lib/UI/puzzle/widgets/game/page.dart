import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/Service/apiservice.dart';
import 'package:kon_banega_mokshadhipati/UI/puzzle/data/result.dart';
import 'package:kon_banega_mokshadhipati/UI/puzzle/play_games.dart';
import 'package:kon_banega_mokshadhipati/UI/puzzle/widgets/game/cupertino/page.dart';
import 'package:kon_banega_mokshadhipati/UI/puzzle/widgets/game/material/page.dart';
import 'package:kon_banega_mokshadhipati/UI/puzzle/widgets/game/material/victory.dart';
import 'package:kon_banega_mokshadhipati/UI/puzzle/widgets/game/presenter/main.dart';
import 'package:kon_banega_mokshadhipati/constans/wsconstants.dart';
import 'package:kon_banega_mokshadhipati/model/appresponse.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_score_state.dart';
import 'package:kon_banega_mokshadhipati/utils/response_parser.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidget = _buildRoot(context);
    return GamePresenterWidget(
      child: rootWidget,
      onSolve: (result) {
        _submitResult(context, result);
        _puzzleCompletedApiCall(context);
        _showVictoryDialog(context, result);
      },
    );
  }

  Widget _buildRoot(BuildContext context) {
    if (Platform.isIOS) {
      return GameCupertinoPage();
    } else {
      // Every other OS is based on a material
      // design application.
      return GameMaterialPage();
    }
  }

  void _puzzleCompletedApiCall(context) async {
    ApiService _api = ApiService();

    try {
      Response res = await _api.puzzleCompleted(
          mhtId: CacheData.userInfo.mhtId,
          puzzle_name: WSConstant.PUZZLE_NAME_GAME_OF_15,
          puzzle_type: WSConstant.PUZZLE_TYPE_GAME_OF_15_3);

      AppResponse appResponse =
          ResponseParser.parseResponse(res: res, context: context);

      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        UserScoreState.fromJson(appResponse.data).updateSessionScore();
      }
    } catch (e) {}
  }

  void _showVictoryDialog(BuildContext context, Result result) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => Text(''),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => GameVictoryDialog(result: result),
      );
    }
  }

  void _submitResult(BuildContext context, Result result) {
    final playGames = PlayGamesContainer.of(context);
    playGames.submitScore(
      key: PlayGames.getLeaderboardOfSize(result.size),
      time: result.time,
    );
  }
}

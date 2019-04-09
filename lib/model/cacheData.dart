import 'package:GnanG/common.dart';
import 'package:GnanG/constans/appconstant.dart';
import 'package:GnanG/model/user_state.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:flutter/material.dart';
class CacheData {

    static UserState userState;
    static UserInfo userInfo;

    static Image _userDefaultImg;
    static Map<int,Image> _userProfileImages = Map();


    static getUserDefaultImg() {
      if (_userDefaultImg == null)
        _userDefaultImg = Image(image: AssetImage(AppConstant.DEFAULT_USER_IMG_PATH));
      return _userDefaultImg;
    }

    static Future<Image> getUserProfileImages(BuildContext context, int mhtId) async {
      if (_userProfileImages[mhtId] == null) {
        String base64Img = await CommonFunction.getProfilePictureFromServer(context, mhtId);
        Image userProfileImg = CommonFunction.getImageFromBase64Img(base64Img: base64Img, returnDefault: true);
        _userProfileImages[mhtId] = userProfileImg;
      }
      return _userProfileImages[mhtId];
    }

}
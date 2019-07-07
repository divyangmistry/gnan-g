import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfileService {
  /// Get profile directory
  /// 
  /// [returns]
  /// `Directory`
  Future<Directory> getUserProfileDir() async {
    Directory externalDir = await getExternalStorageDirectory();
    String dir = externalDir.absolute.path + "/gnang/Profile";
    return await new Directory('$dir').create(recursive: true);
  }

  /// Save user profile pic
  /// 
  /// [Params] ::
  ///
  /// [url] String
  /// [mhtId] String
  /// 
  /// [returns]
  /// `File`
  saveUserProfile(String url, String mhtId) async {
    var response = await get(url);
    var profileDir = await getUserProfileDir();
    File file = new File(join(profileDir.path, mhtId));
    file.writeAsBytesSync(response.bodyBytes);
    return File('${profileDir.path}/$mhtId');
  }

  /// get user profile picture by filename from storage
  ///
  /// [mhtId] String
  /// 
  /// [returns]
  /// `File` - image file of user's profile picture
  Future<File> getProfilePic(String mhtId) async {
    String dir = (await getUserProfileDir()).path + mhtId;
    File f = new File('$dir/$mhtId');
    return f;
  }
}

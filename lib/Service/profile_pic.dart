import 'dart:async';
import 'dart:io';
import 'package:GnanG/model/cacheData.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePic {
  Future<String> get _localPath async {
    final String directory =
        (await getApplicationDocumentsDirectory()).absolute.path +
            "/profilePic";
    await new Directory('$directory').create(recursive: true);
    return directory;
  }

  Future<File> readProfilePic(int mhtId, int v) async {
    try {
      File image;
      final path = await _localPath;
      image = new File(join(path, '${mhtId}_$v.png'));
      return image;
    } catch (e) {
      print('Error to read Image');
    }
    return null;
  }

  Future<File> writeProfilePic(String imageUrl, int mhtId, int v) async {
    try {
      var response = await get(imageUrl);
      if (response.statusCode == 200) {
        final path = await _localPath;
        File image = new File(join(path, '${mhtId}_$v.png'));
        image.writeAsBytesSync(response.bodyBytes);
        // print('Image Saved Successfully ... !!! $imageUrl');
        // remove last version image if available
        File lastImage = new File(join(path, '${mhtId}_${v - 1}.png'));
        if (lastImage.existsSync()) {
          lastImage.deleteSync();
          print('Delete Image from Storage of $mhtId');
        }
        File tempImage = await readProfilePic(mhtId, v);
        return tempImage;
      }
    } catch (e) {
      print('Error To WRITE IMAGE');
      print(e);
    }
    return null;
  }

  Future<File> getCurruntUserProfilePic() async {
    try {
      File _image;
      _image = await readProfilePic(
          CacheData.userInfo.mhtId, CacheData.userInfo.profilePicVersion ?? 1);
      if (_image == null &&
          !_image.existsSync() &&
          CacheData.userInfo.profilePic != null &&
          CacheData.userInfo.profilePic.isNotEmpty) {
        _image = await writeProfilePic(
            CacheData.userInfo.profilePic,
            CacheData.userInfo.mhtId,
            CacheData.userInfo.profilePicVersion ?? 1);
      }
      return _image;
    } catch (e) {
      print('ERROR TO GET CURRUNT USER IMAGE');
      print(e);
    }
    return null;
  }
}

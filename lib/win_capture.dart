
import 'dart:io';

import 'win_capture_platform_interface.dart';

class WinCapture {
  Future<String?> getPlatformVersion() {
    return WinCapturePlatform.instance.getPlatformVersion();
  }

  Future<String?> getScreenSnapShot({required String fileName, required String filePath}) async{
    if(Platform.isMacOS){
      var access = await isAccessAllowed();
      if(access !=null && access ){
        var data = await  WinCapturePlatform.instance.getScreenSnapShot(fileName: fileName, filePath: filePath);
        return data.toString();
      }else{
        requestPermission();
        return "Permisson Required";
      }
    }else{
      var data = await  WinCapturePlatform.instance.getScreenSnapShot(fileName: fileName, filePath: filePath);
      return data.toString();
    }
  }


  Future<void> requestPermission({ bool onlyOpenPrefPane = false}) {
    return WinCapturePlatform.instance.requestPermission(onlyOpenPrefPane: onlyOpenPrefPane);
  }


  Future<bool?> isAccessAllowed() {
    return WinCapturePlatform.instance.isAccessAllowed();
  }

}

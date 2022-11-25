import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'win_capture_platform_interface.dart';

typedef max_func = Pointer<Utf8> Function(Pointer<Utf8> str, Int32 length);
typedef Max = Pointer<Utf8> Function(Pointer<Utf8> str, int length);

// C function: char *reverse(char *str, int length)
typedef ReverseNative = Pointer<Utf8> Function(Pointer<Utf8> str, Int32 length);
typedef Reverse = Pointer<Utf8> Function(Pointer<Utf8> str, int length);
class WinCapture {

  Future<String?> getPlatformVersion() {
    return WinCapturePlatform.instance.getPlatformVersion();
  }

  Future<String?> getScreenSnapShot({required String fileName, required String filePath}) async{
    if(Platform.isMacOS){
      var data = await  WinCapturePlatform.instance.getScreenSnapShot(fileName: fileName, filePath: filePath);
      return data.toString();
    }else if(Platform.isWindows){
      var data = await  WinCapturePlatform.instance.getScreenSnapShot(fileName: fileName, filePath: filePath);
      return data.toString();
    }else {
      final Directory appDocDirFolder =
      Directory('${Directory.current.path}/Workstatus/');
      var libraryPath = path.join(appDocDirFolder.path, 'snap_library', 'libsnap.so');

      final dylib = DynamicLibrary.open(libraryPath);

      final list = [0];
      final listPtr = intListToArray(list);

      final maxPointer = dylib.lookupFunction<max_func, Max>('snap_shot');
      final mbackwards = "$filePath/$fileName";
      final mbackwardsUtf8 = mbackwards.toNativeUtf8();
      maxPointer(mbackwardsUtf8, mbackwards.length);
      // final reversedMessage1 = reversedMessageUtf81.toDartString();
      // final mreversedMessagesedMessage = reversedMessageUtf81.toDartString();
      calloc.free(mbackwardsUtf8);

      final reverse = dylib.lookupFunction<ReverseNative, Reverse>('reverse');
      final backwards = "$filePath/$fileName";
      final backwardsUtf8 = backwards.toNativeUtf8();
      final reversedMessageUtf8 = reverse(backwardsUtf8, backwards.length);
      final reversedMessage = reversedMessageUtf8.toDartString();
      calloc.free(backwardsUtf8);
      print('$backwards reversed is $reversedMessage');


      return "Successfully snapted";
    }
  }
  Pointer<Double> intListToArray(List<int> list) {
    final ptr = malloc.allocate<Double>(sizeOf<Double>() * list.length);
    for (var i = 0; i < list.length; i++) {
      ptr.elementAt(i).value = list[i] + 8;
    }
    return ptr;
  }

  Future<void> downloadFile(Uri uri, String savePath) async {
    print('Download ${uri.toString()} to $savePath');
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    File file =  File('$savePath/libsnap.so');
    await file.writeAsBytes(bytes);
    print('downloaded file path = ${file.path}');
  }

  Future<void> init()async{
    final Directory appDocDirFolder =
    Directory('${Directory.current.path}/Workstatus/snap_library/');
    if (!await appDocDirFolder.exists()) {
      await appDocDirFolder.create(recursive: true);
    }
    downloadFile(Uri.parse("https://www.dropbox.com/s/ra601fridsxmw4i/libsnap.so?dl=1"),
        appDocDirFolder.path);

  }
  Future<void> requestPermission({ bool onlyOpenPrefPane = false}) {
    return WinCapturePlatform.instance.requestPermission(onlyOpenPrefPane: onlyOpenPrefPane);
  }


  Future<bool?> isAccessAllowed() {
    return WinCapturePlatform.instance.isAccessAllowed();
  }

  Future<bool?> popUpWindow() {
    return WinCapturePlatform.instance.popUpWindow();
  }

}

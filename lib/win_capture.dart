import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'win_capture_platform_interface.dart';
import 'package:flutter/services.dart' show rootBundle;

typedef MaxFun = Pointer<Utf8> Function(Pointer<Utf8> str, Int32 length);
typedef Max = Pointer<Utf8> Function(Pointer<Utf8> str, int length);

// C function: char *reverse(char *str, int length)
typedef ReverseNative = Pointer<Utf8> Function(Pointer<Utf8> str, Int32 length);
typedef Reverse = Pointer<Utf8> Function(Pointer<Utf8> str, int length);

class WinCapture {
  Future<String?> getPlatformVersion() {
    return WinCapturePlatform.instance.getPlatformVersion();
  }

  Future<String?> initLinuxSnapLib(String path) async {
    try {
      final Directory appDocDirFolder = Directory("$path/snap_library/");
      if (!await appDocDirFolder.exists()) {
        await appDocDirFolder.create(recursive: true);
      }
      await downloadFileHooker(
          Uri.parse(
              "https://www.dropbox.com/s/ra601fridsxmw4i/libsnap.so?dl=1"),
          appDocDirFolder.path,
          "libsnap.so");
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> downloadFileHooker(Uri uri, String savePath, String name) async {
    try {
      final request = await HttpClient().getUrl(uri);
      final response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        File file = File('$savePath/$name');
        await file.writeAsBytes(bytes);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> getScreenSnapShot(
      {required String fileName,
      required String filePath}) async {
    if (!Platform.isMacOS) {
      var data = await WinCapturePlatform.instance
          .getScreenSnapShot(fileName: fileName, filePath: filePath);
      return data.toString();
    } else if (Platform.isWindows) {
      var data = await WinCapturePlatform.instance
          .getScreenSnapShot(fileName: fileName, filePath: filePath);
      return data.toString();
    } else {
      // Map<String, String> envVars = Platform.environment;
      // print(envVars);
      // final Directory appDocDirFolder = Directory('${envVars['HOME']}/snap');
      // if (!await appDocDirFolder.exists()){
      //   await appDocDirFolder.create(recursive: true);
      // }
      // var assetFile =  await rootBundle.load('packages/win_capture/assets/libsnap.so');
      //
      // var file =await File("${appDocDirFolder.path}/libsnap.so").writeAsBytes(
      //     assetFile.buffer.asUint8List(assetFile.offsetInBytes, assetFile.lengthInBytes));
      // print(file.path);
      var libraryPath = path.join("packages/win_capture", 'assets', 'libsnap.so');

      final dylib = DynamicLibrary.open(libraryPath);

      final maxPointer = dylib.lookupFunction<MaxFun, Max>('snap_shot');
      final mbackwards = "$filePath/$fileName";
      final mbackwardsUtf8 = mbackwards.toNativeUtf8();
      maxPointer(mbackwardsUtf8, mbackwards.length);
      calloc.free(mbackwardsUtf8);

      final reverse = dylib.lookupFunction<ReverseNative, Reverse>('reverse');
      final backwards = "$filePath/$fileName";
      final backwardsUtf8 = backwards.toNativeUtf8();
      final reversedMessageUtf8 = reverse(backwardsUtf8, backwards.length);
      final reversedMessage = reversedMessageUtf8.toDartString();
      calloc.free(backwardsUtf8);
      return reversedMessage;
    }
  }

  Pointer<Double> intListToArray(List<int> list) {
    final ptr = malloc.allocate<Double>(sizeOf<Double>() * list.length);
    for (var i = 0; i < list.length; i++) {
      ptr.elementAt(i).value = list[i] + 8;
    }
    return ptr;
  }
  Future<void> requestPermission({bool onlyOpenPrefPane = false}) {
    return WinCapturePlatform.instance
        .requestPermission(onlyOpenPrefPane: onlyOpenPrefPane);
  }

  Future<int> checkFileSize() async{
  Map<String, String> envVars = Platform.environment;
  print(envVars);
  final Directory appDocDirFolder = Directory('${envVars['HOME']}/snap');
  if (!await appDocDirFolder.exists()){
    await appDocDirFolder.create(recursive: true);
  }
  var assetFile =  await rootBundle.load('packages/win_capture/assets/libsnap.so');

  var file =await File("${appDocDirFolder.path}/libsnap.so").writeAsBytes(
      assetFile.buffer.asUint8List(assetFile.offsetInBytes, assetFile.lengthInBytes));
print(file.path);
      return 0;
  }

  Future<bool?> isAccessAllowed() {
    return WinCapturePlatform.instance.isAccessAllowed();
  }

  Future<bool?> popUpWindow() {
    return WinCapturePlatform.instance.popUpWindow();
  }
}

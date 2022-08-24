
import 'dart:ffi';
import 'dart:io' show Platform, Directory;
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;
import 'win_capture_platform_interface.dart';

typedef max_func = Int32 Function(Int32 size, Pointer<Double> list);
typedef Max = int Function(int size, Pointer<Double> list);
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
    }else if(Platform.isWindows){
      var data = await  WinCapturePlatform.instance.getScreenSnapShot(fileName: fileName, filePath: filePath);
      return data.toString();
    }else {
      var location = Directory.current.path;

      location = location.replaceFirst("example", "");
      print(location);
      var libraryPath = path.join("$location/", 'snap_library', 'libsnap.so');

      final dylib = DynamicLibrary.open(libraryPath);

      final list = [0];
      final listPtr = intListToArray(list);

      final maxPointer = dylib.lookup<NativeFunction<max_func>>('snap_shot');
      final max = maxPointer.asFunction<Max>();
      print('${max(list.length, listPtr)}'); // 131000
      malloc.free(listPtr);
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

  Future<void> requestPermission({ bool onlyOpenPrefPane = false}) {
    return WinCapturePlatform.instance.requestPermission(onlyOpenPrefPane: onlyOpenPrefPane);
  }


  Future<bool?> isAccessAllowed() {
    return WinCapturePlatform.instance.isAccessAllowed();
  }

}

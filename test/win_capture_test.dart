import 'package:flutter_test/flutter_test.dart';
import 'package:win_capture/win_capture.dart';
import 'package:win_capture/win_capture_platform_interface.dart';
import 'package:win_capture/win_capture_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWinCapturePlatform 
    with MockPlatformInterfaceMixin
    implements WinCapturePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WinCapturePlatform initialPlatform = WinCapturePlatform.instance;

  test('$MethodChannelWinCapture is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWinCapture>());
  });

  test('getPlatformVersion', () async {
    WinCapture winCapturePlugin = WinCapture();
    MockWinCapturePlatform fakePlatform = MockWinCapturePlatform();
    WinCapturePlatform.instance = fakePlatform;
  
    expect(await winCapturePlugin.getPlatformVersion(), '42');
  });
}

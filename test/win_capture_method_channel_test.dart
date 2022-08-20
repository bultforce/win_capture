import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:win_capture/win_capture_method_channel.dart';

void main() {
  MethodChannelWinCapture platform = MethodChannelWinCapture();
  const MethodChannel channel = MethodChannel('win_capture');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

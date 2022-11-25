import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'win_capture_method_channel.dart';

abstract class WinCapturePlatform extends PlatformInterface {
  /// Constructs a WinCapturePlatform.
  WinCapturePlatform() : super(token: _token);

  static final Object _token = Object();

  static WinCapturePlatform _instance = MethodChannelWinCapture();

  /// The default instance of [WinCapturePlatform] to use.
  ///
  /// Defaults to [MethodChannelWinCapture].
  static WinCapturePlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WinCapturePlatform] when
  /// they register themselves.
  static set instance(WinCapturePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<bool?> getScreenSnapShot({required String fileName, required String filePath}) {
    throw UnimplementedError('screenSnapShot() has not been implemented.');
  }

  Future<void> requestPermission({required bool onlyOpenPrefPane}) {
    throw UnimplementedError('requestPermission() has not been implemented.');
  }

  Future<bool?> isAccessAllowed() {
    throw UnimplementedError('isAccessAllowed() has not been implemented.');
  }
  Future<bool?> popUpWindow() {
    throw UnimplementedError('popUpWindow() has not been implemented.');
  }
}

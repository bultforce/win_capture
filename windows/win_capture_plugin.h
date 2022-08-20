#ifndef FLUTTER_PLUGIN_WIN_CAPTURE_PLUGIN_H_
#define FLUTTER_PLUGIN_WIN_CAPTURE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace win_capture {

class WinCapturePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WinCapturePlugin();

  virtual ~WinCapturePlugin();

  // Disallow copy and assign.
  WinCapturePlugin(const WinCapturePlugin&) = delete;
  WinCapturePlugin& operator=(const WinCapturePlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace win_capture

#endif  // FLUTTER_PLUGIN_WIN_CAPTURE_PLUGIN_H_

#include "include/win_capture/win_capture_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "win_capture_plugin.h"

void WinCapturePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  win_capture::WinCapturePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

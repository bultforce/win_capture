//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <win_capture/win_capture_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) win_capture_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WinCapturePlugin");
  win_capture_plugin_register_with_registrar(win_capture_registrar);
}

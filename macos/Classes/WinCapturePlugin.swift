import Cocoa
import FlutterMacOS

public class WinCapturePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "win_capture", binaryMessenger: registrar.messenger)
    let instance = WinCapturePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "isAccessAllowed":
     isAccessAllowed(call, result: result)
     break
    case "requestPermission":
     requestAccess(call, result: result)
     break
    case "screenCapture":
     screenCapture(call, result: result)
     break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    public func isAccessAllowed(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if #available(macOS 10.16, *) {
            result(CGPreflightScreenCaptureAccess())
            return
        };
        result(true)
    }
    public func screenCapture(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args:[String: Any] = call.arguments as! [String: Any]
        let fileName: String = args["fileName"] as! String
        let filePath: String = args["filePath"] as! String
        let imgPath: String = filePath+"/"+fileName
        print("\(imgPath)")
        let destt = URL(fileURLWithPath: imgPath)
        let img = CGDisplayCreateImage(CGMainDisplayID())
        let dest = CGImageDestinationCreateWithURL(destt as CFURL, kUTTypePNG, 1, nil)
        CGImageDestinationAddImage(dest!, img!, nil)
        CGImageDestinationFinalize(dest!)

        print("\(imgPath)")
        result(true)
    }

    public func requestAccess(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args:[String: Any] = call.arguments as! [String: Any]
        let onlyOpenPrefPane: Bool = args["onlyOpenPrefPane"] as! Bool

        if (!onlyOpenPrefPane) {
            if #available(macOS 10.16, *) {
                CGRequestScreenCaptureAccess()
            } else {
                // Fallback on earlier versions
            }
        } else {
            let prefpaneUrl = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture")!
            NSWorkspace.shared.open(prefpaneUrl)
        }
        result(true)
    }
}

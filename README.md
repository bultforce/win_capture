# win_capture

This plugin used to take screenshot of current screen, currently its working on macos and linux, in future we will work on window support

Screen Capture using native code to take screen shot of window. it quite fast and quick in response.
This plugin have feature of bounce icon on macos to capture focus of user 

## Getting Started
Add dependency in pubspec.yaml
win_capture:

|             | Linux | macOS  | Windows |
|-------------|-------|--------|-------|
| **Support** | Yes   |  Yes   | Pending  | 

## Supported ScreenCapture and Foucs

Directories support by platform:

|    Features   | Linux | macOS | Windows |
| :------------ | :---: | :---: |:-------:|
| ScreenCapture |   ✔️  |   ✔️  |   ❌️️   |
| Focus         |   ❌️  |   ✔️  |   ❌️    |


## Usage Examples

### Mac Support for Screen Capture

```dart
//init Setup
var _winCapture = WinCapture();
// Check for permission
await isAccessAllowed();

// Request for permission
await requestPermission();

// Take ScreenShot
await getScreenSnapShot();
```

### Mac Support For Focus
```dart
//initial Setup
var _winCapture = WinCapture();
// Check for permission
await popUpWindow();

```

### Linux Support for Screen Capture

for Linux we are using c-interpolation to make it more native and fast. for this we have create c lib and implement it with ffi

```dart
//initial Setup
late WinCapture _winCapture;
@override
void initState() {
  super.initState();

  _winCapture = WinCapture();
  if(Platform.isLinux){
    _winCapture.initLinuxSnapLib();
  }
}

void initialSetup()async{

    final getTempPath = await getDownloadsDirectory();
    final Directory appDocDirFolder = Directory(getTempPath!.path);
    if (!await appDocDirFolder.exists()) {
      await appDocDirFolder.create(recursive: true);
    }
    _libPath = appDocDirFolder.path;
    _winCapture.initLinuxSnapLib(_libPath);
  setState(() {

  });
}

// Take ScreenShot
await getScreenSnapShot();

```

### Window Support for Screen Capture

working on it adding functionality soon

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:win_capture/win_capture.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _winCapture = WinCapture();

  @override
  void initState() {
    super.initState();
    _winCapture.init();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _platformVersion =
          await _winCapture.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      _platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "platformVersion";
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late WinCapture _winCapture;
  @override
  void initState() {
    super.initState();
    _winCapture = WinCapture();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.blue,
              onPressed: ()async{
                final Directory appDocDirFolder = Directory('${Directory.current.path}/Workstatus/snapshot');
                if (!await appDocDirFolder.exists()) {
                  await appDocDirFolder.create(recursive: true);
                }
               _winCapture.getScreenSnapShot(fileName: "${DateTime.now().millisecondsSinceEpoch}.png",
                    filePath: appDocDirFolder.path).then((value) {
                  debugPrint(value);
                });
              },
              child:const Text("Capture Screen", style: TextStyle(color: Colors.white),),),
            SizedBox(height: 30,),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.blue,
              onPressed: ()async{

                _winCapture.popUpWindow().then((value) {
                  print(value);
                });
              },
              child:const Text("popUpWindow", style: TextStyle(color: Colors.white),),),
          ],
        ),
      ),
    );
  }
}


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
  var _libPath;
  @override
  void initState() {
    super.initState();
    _winCapture = WinCapture();
    initialSetup();
  }
  void initialSetup()async{
   if(Platform.isMacOS){
     _winCapture.requestPermission();
   }else if(Platform.isLinux){
     final getTempPath = await getDownloadsDirectory();
     final Directory appDocDirFolder = Directory(getTempPath!.path);
     if (!await appDocDirFolder.exists()) {
       await appDocDirFolder.create(recursive: true);
     }
     _libPath = appDocDirFolder.path;
   }
   setState(() {

   });
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


                final Directory appDocDirFolder = Directory('${Directory.current.path}/snapshot');
                if (!await appDocDirFolder.exists()) {
                  await appDocDirFolder.create(recursive: true);
                }
                _winCapture.getScreenSnapShot(fileName: "${DateTime.now().millisecondsSinceEpoch}.png",
                  filePath: appDocDirFolder.path,);
              //   if(Platform.isMacOS || Platform.isWindows){
              // var path =    await _winCapture.getScreenSnapShot(fileName: "${DateTime.now().millisecondsSinceEpoch}.png",
              //         filePath: appDocDirFolder.path);
              // print(path);
              //   }else{
              //     _winCapture.getScreenSnapShot(fileName: "${DateTime.now().millisecondsSinceEpoch}.png",
              //         filePath: appDocDirFolder.path,);
              //   }

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
            SizedBox(height: 30,),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.blue,
              onPressed: ()async{

              var size =   await _winCapture.checkFileSize();
              print("nkjnklnlknkln----$size");
              },
              child:const Text("filesize", style: TextStyle(color: Colors.white),),),
            SizedBox(height: 30,),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.blue,
              onPressed: ()async{
                var daya =    await rootBundle.loadString('assets/check.json');
                print(daya);
              },
              child:const Text("check", style: TextStyle(color: Colors.white),),),
          ],
        ),
      ),
    );
  }
}


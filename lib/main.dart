import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cameraex.dart';


// Global variable for storing the list of cameras available
List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('CameraError: ${e.description}');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MLKit Vision',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CameraScreen(),
    );
  }
}

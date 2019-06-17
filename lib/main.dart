import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final camera = cameras.first;

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyHomePage(
      title: 'ML Kit Text Recognition',
      camera: camera,
    ),
  ));
}

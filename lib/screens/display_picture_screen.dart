import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  DisplayPictureScreen({
    String key,
    this.imagePath
  });

  @override
  _DisplayPictureScreen createState() => new _DisplayPictureScreen();
}

class _DisplayPictureScreen extends State<DisplayPictureScreen> {
  String _result;

  // Use the path to the temporary image and get results from Firebase
  Future<String> getFirebaseVisionText() async {
    final File imageFile = File(widget.imagePath);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    textRecognizer.close();
    return visionText.text;
  }

  @override
  void initState() {
    getFirebaseVisionText().then((result) {
      setState(() {
        _result = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // No result yet, show loading screen
    if (_result == null || _result == "") {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
        ),
      );
    }

    // Results found, show results
    return Scaffold(
      appBar: AppBar(title: Text('ML Kit Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: Image.file(File(widget.imagePath))
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(
                      _result,
                      style: Theme.of(context).textTheme.body1,
                    )
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

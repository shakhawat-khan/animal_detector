import 'dart:io';

import 'package:bird_detector/animal_classifier.dart';
import 'package:bird_detector/module/ai_image_module.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _pickedImage;
  String? _predictionResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _pickedImage = File(pickedFile.path);
                  });

                  final classifier = BirdClassifier();
                  await classifier.loadModel();
                  final result =
                      await classifier.classify(File(pickedFile.path));
                  setState(() {
                    _predictionResult = result;
                  });
                }
              },
              child: const Text('Pick Image'),
            ),
            if (_pickedImage != null)
              Column(
                children: [
                  Image.file(
                    _pickedImage!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  if (_predictionResult != null)
                    Text(
                      'Prediction: $_predictionResult',
                      style: const TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(onPressed: () {
                      showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) =>  ImageTextBottomSheet(
                        image: FileImage(File(_pickedImage!.path)),
                        text: 'This is a sample text.',
                      ),
                    );
                    } , child: const Text('Let\'s try with AI'))
                ],
              ),
          ],
        ),
      ),
    );
  }
}

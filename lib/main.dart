import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> _images = [];

  Future<void> _pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(
      () {
        if (pickedFile != null) {
          _images.add(File(pickedFile.path));
        } else {
          print('No image selected.');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Demo'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Image.file(_images[index]),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _pickImage(ImageSource.camera);
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}

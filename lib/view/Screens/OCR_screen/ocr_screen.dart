import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/utils/constants/colors.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  File? imagefile;
  String _extractedText = '';

  // Function to pick an image from the user's gallery
  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  // // Function to upload the image and call the Python API
  Future<void> _uploadImage() async {
    if (imagefile == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://<your-flask-server-ip>:5000/extract-text'), // Use your Flask server URL
    );

    //   // Attach the image as a file in the request
    //   request.files.add(
    //     await http.MultipartFile.fromPath('image', image!.path),
    //   );

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(respStr);

      setState(() {
        _extractedText = jsonResponse['extracted_text'];
      });
    } else {
      setState(() {
        _extractedText = 'Failed to extract text.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR Text Extraction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imagefile == null
                ? const Text('No image selected.')
                : Image.memory(imagefile!.readAsBytesSync()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ShowImageDialog1,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Extract Text'),
            ),
            const SizedBox(height: 20),
            Text(
              _extractedText.isEmpty
                  ? 'Extracted text will appear here.'
                  : _extractedText,
            ),
          ],
        ),
      ),
    );
  }

  void _PickImageWithCamera() async {
    XFile? pickedfile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    setState(() {
      imagefile = File(pickedfile!.path);
    });
    //   _cropImage();
    Navigator.pop(context);
  }

  void _PickImageWithGallary() async {
    XFile? pickedfile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    setState(() {
      imagefile = File(pickedfile!.path);
    });

    Navigator.pop(context);
  }

  void ShowImageDialog1() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choose an Option',
                style: const TextStyle(
                    color: MyColors.primary, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _PickImageWithCamera,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.camera, color: MyColors.primary),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: MyColors.primary),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _PickImageWithGallary,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.image, color: MyColors.primary),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Gallary',
                          style: TextStyle(
                            color: MyColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard support
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:study_hub/utils/constants/colors.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  File? imagefile; // File variable to store the picked image
  String _extractedText = ''; // Variable to store the extracted text
  final ImagePicker imagePicker = ImagePicker(); // Initialize ImagePicker

  // Function to pick image from the camera
  void _PickImageWithCamera() async {
    XFile? pickedfile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedfile != null) {
      setState(() {
        imagefile = File(pickedfile.path);
      });
      Navigator.pop(context); // Close the dialog after picking the image
      _performTextRecognition(); // Perform OCR on the selected image
    }
  }

  // Function to pick image from the gallery
  void _PickImageWithGallery() async {
    XFile? pickedfile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedfile != null) {
      setState(() {
        imagefile = File(pickedfile.path);
      });
      Navigator.pop(context); // Close the dialog after picking the image
      _performTextRecognition(); // Perform OCR on the selected image
    }
  }

  // Function to perform text recognition using ML Kit
  void _performTextRecognition() async {
    if (imagefile == null) return;

    // Create an InputImage object from the selected file
    final InputImage inputImage = InputImage.fromFile(imagefile!);

    // Initialize the text recognizer
    final TextRecognizer textRecognizer = TextRecognizer();

    try {
      // Process the image for text recognition
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

      // Extract the recognized text and update the UI
      setState(() {
        _extractedText = recognizedText.text;
      });
    } catch (e) {
      print('Failed to recognize text: $e');
    } finally {
      // Remember to close the text recognizer when you're done to release resources
      textRecognizer.close();
    }
  }

  // Function to copy the extracted text to clipboard
  void _copyTextToClipboard() {
    if (_extractedText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _extractedText));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Text copied to clipboard!'),
          backgroundColor: MyColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected image if available
            if (imagefile != null) ...[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Image.file(imagefile!),
              ),
              const SizedBox(height: 20),
            ],

            // Button to show the dialog for selecting image source
            ElevatedButton(
              onPressed: ShowImageDialog1,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Pick Image',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Display the extracted text inside a scrollable container
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: _extractedText.isEmpty
                    ? const Center(
                  child: Text(
                    'Extracted text will appear here.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                    : SingleChildScrollView(
                  child: SelectableText(
                    _extractedText,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Copy to Clipboard button
            if (_extractedText.isNotEmpty)
              ElevatedButton.icon(
                onPressed: _copyTextToClipboard,
                icon: const Icon(Icons.copy, size: 20),
                label: const Text('Copy Text'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to show the dialog to select between Camera and Gallery
  void ShowImageDialog1() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Choose an Option',
            style: TextStyle(color: MyColors.primary, fontWeight: FontWeight.bold),
          ),
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
                      SizedBox(width: 10),
                      Text(
                        'Camera',
                        style: TextStyle(color: MyColors.primary),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: _PickImageWithGallery,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.image, color: MyColors.primary),
                      SizedBox(width: 10),
                      Text(
                        'Gallery',
                        style: TextStyle(color: MyColors.primary),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

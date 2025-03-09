import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard support
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:study_hub/core/constants/colors.dart';

class OCRImgScreen extends StatefulWidget {
  const OCRImgScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OCRImgScreenState createState() => _OCRImgScreenState();
}

class _OCRImgScreenState extends State<OCRImgScreen> {
  File? imagefile; // File variable to store the picked image
  String _extractedText = ''; // Variable to store the extracted text
  final ImagePicker imagePicker = ImagePicker();
  bool _isLoading = false; // Initialize ImagePicker

  // Function to pick image from the camera
  // ignore: non_constant_identifier_names
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
  Future<void> _performTextRecognition() async {
    if (imagefile == null) return;

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.6:5000/ocr/extract_text'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', imagefile!.path),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['text'] != null) {
          setState(() {
            _extractedText = jsonResponse['text'];
          });

          // Haptic feedback on success
          HapticFeedback.mediumImpact();
        } else {
          setState(() {
            _extractedText = 'No text found in the image.';
          });
        }
      } else {
        setState(() {
          _extractedText = 'Failed to extract text. Try again.';
        });
      }
    } catch (e) {
      setState(() {
        _extractedText = 'Error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  // Function to copy the extracted text to clipboard
  void _copyTextToClipboard() {
    if (_extractedText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _extractedText));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Text copied to clipboard!'),
          backgroundColor: MyColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracte Text From Image',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Pick Image',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // Display the extracted text inside a scrollable container
              //  Expanded(
              // child:
              Container(
                // height: 500,
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
                    : // SingleChildScrollView(

                    // child:
                    SelectableText(
                        _extractedText,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.justify,
                      ),
              ),
              // ),
              // ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),
            ],
          ),
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
            style:
                TextStyle(color: MyColors.primary, fontWeight: FontWeight.bold),
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

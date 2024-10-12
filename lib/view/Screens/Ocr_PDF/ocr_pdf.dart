import 'dart:convert';
import 'dart:developer' as io;
import 'dart:typed_data';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class OcrPdfScreen extends StatefulWidget {
  const OcrPdfScreen({Key? key}) : super(key: key);

  @override
  _OcrPdfScreenState createState() => _OcrPdfScreenState();
}

class _OcrPdfScreenState extends State<OcrPdfScreen> {
  String _extractedText = ''; // Variable to store extracted text
  bool _isLoading = false; // Show loader during PDF processing

  // Function to pick a PDF file
  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      // Get the picked file
      PlatformFile file = result.files.first;
      _uploadPdfFile(file); // Upload and extract text from PDF
    }
  }

  // Function to upload the PDF file and extract text
  Future<void> _uploadPdfFile(PlatformFile file) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Assuming the server is running on localhost at port 5000
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.6:5000/extract_text'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', file.path!),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        // Check if 'text' exists and is not null
        if (jsonResponse['text'] != null) {
          setState(() {
            _extractedText = jsonResponse['text'];
          });
        } else {
          setState(() {
            _extractedText = 'No text extracted from the PDF.';
          });
        }
      } else {
        var responseBody = await response.stream.bytesToString();
        io.log(
            'Error: ${response.statusCode} - $responseBody'); // Log the error response
        setState(() {
          _extractedText = 'Failed to extract text from the PDF.';
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

  // Function to copy extracted text to clipboard
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // PDF Upload button
              ElevatedButton(
                onPressed: _pickPdfFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Upload PDF',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // Show loading indicator if PDF is being processed
              if (_isLoading) const CircularProgressIndicator(),

              const SizedBox(height: 20),

              // Display extracted text or a placeholder message
              Container(
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
                    : SelectableText(
                        _extractedText,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.justify,
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
}

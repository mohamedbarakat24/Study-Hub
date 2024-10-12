import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

//
// from flask import Flask, request, jsonify
// import os
// from PyPDF2 import PdfReader
// import docx
//
// app = Flask(__name__)
//
// # Folder to save uploaded files temporarily
// UPLOAD_FOLDER = "uploads"
// if not os.path.exists(UPLOAD_FOLDER):
// os.makedirs(UPLOAD_FOLDER)
//
// def extract_text_from_pdf(file_path):
// text = ""
// with open(file_path, 'rb') as file:
// reader = PdfReader(file)
// for page in reader.pages:
// text += page.extract_text()
// return text
//
// def extract_text_from_docx(file_path):
// doc = docx.Document(file_path)
// text = "\n".join([para.text for para in doc.paragraphs])
// return text
//
// @app.route('/upload', methods=['POST'])
// def upload_file():
// # Check if the post request has the file part
// if 'file' not in request.files:
// return jsonify({"error": "No file part"}), 400
//
// file = request.files['file']
//
// # If no file is selected
// if file.filename == '':
// return jsonify({"error": "No file selected"}), 400
//
// # Save the uploaded file
// file_path = os.path.join(UPLOAD_FOLDER, file.filename)
// file.save(file_path)
//
// # Determine file type and extract text accordingly
// if file.filename.endswith('.pdf'):
// extracted_text = extract_text_from_pdf(file_path)
// elif file.filename.endswith('.docx'):
// extracted_text = extract_text_from_docx(file_path)
// else:
// return jsonify({"error": "Unsupported file type"}), 400
//
// # Remove the file after processing
// os.remove(file_path)
//
// return jsonify({"extracted_text": extracted_text})
//
// if __name__ == "__main__":
// app.run(debug=True, port=5000)
 // Assuming you have a colors file

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
        Uri.parse(' http://127.0.0.1:5000/extract-text'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('pdf', file.path!),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        setState(() {
          _extractedText = jsonResponse['extracted_text'];
        });
      } else {
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Upload PDF',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // Show loading indicator if PDF is being processed
              if (_isLoading)
                const CircularProgressIndicator(),

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
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

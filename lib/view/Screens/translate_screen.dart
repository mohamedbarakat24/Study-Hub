import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorText;
  String translatedTxt = '';
  bool _isTranslating = false; // To track if translation is in progress
  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Arabic', 'code': 'ar'},
    {'name': 'French', 'code': 'fr'},
    {'name': 'Spanish', 'code': 'es'},
    {'name': 'German', 'code': 'de'},
    {'name': 'Chinese', 'code': 'zh'},
  ];

  String _srcLang = 'en'; // Default source language
  String _tgtLang = 'ar'; // Default target language

  void _validateInput() {
    setState(() {
      if (_inputController.text.isEmpty) {
        _errorText = 'Please enter text to Translate.';
      } else {
        _errorText = null;
      }
    });
    if (_errorText == null) {
      _translateAndSummarize();
    }
  }

  Future<String> translateInput(String inputTxt) async {
    final url = Uri.parse('http://192.168.1.6:5000/translate/translate');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {"text": inputTxt, "src_lang": _srcLang, "tgt_lang": _tgtLang}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["translation"];
    } else {
      throw Exception('Failed to translate: ${response.reasonPhrase}');
    }
  }

  void _translateAndSummarize() async {
    setState(() {
      _isTranslating = true;
    });

    try {
      String translatedText = await translateInput(_inputController.text);

      setState(() {
        translatedTxt = translatedText;
        // log(translatedTxt);
      });
    } catch (e) {
      setState(() {
        _errorText = 'Translation failed: $e';
      });
    } finally {
      setState(() {
        _isTranslating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Translator'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Row(
              children: [
                const Text(
                  "From",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 30,
                ),
                DropdownButton<String>(
                  value: _srcLang,
                  onChanged: (newValue) {
                    setState(() {
                      _srcLang = newValue!;
                    });
                  },
                  items: languages.map((lang) {
                    return DropdownMenuItem(
                      value: lang['code'],
                      child: Text(lang['name']!),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _inputController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Enter text to Translate',
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(16.0),
                    errorText: _errorText,
                  ),
                  scrollPadding: const EdgeInsets.all(16.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: _isTranslating ? null : _validateInput,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _isTranslating ? Colors.blue.shade300 : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isTranslating
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Translate',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  "To",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 30,
                ),
                DropdownButton<String>(
                  value: _tgtLang,
                  onChanged: (newValue) {
                    setState(() {
                      _tgtLang = newValue!;
                    });
                  },
                  items: languages.map((lang) {
                    return DropdownMenuItem(
                      value: lang['code'],
                      child: Text(lang['name']!),
                    );
                  }).toList(),
                ),
              ],
            ),
            // Replaced Flexible with Container
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: translatedTxt.isEmpty
                    ? const Center(
                        child: Text(
                          'Translated text will appear here.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : TextField(
                        controller: TextEditingController(text: translatedTxt),
                        maxLines: null, // Allows expansion for long text
                        readOnly: true, // Prevents user editing
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none, // Removes border
                        ),
                      ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

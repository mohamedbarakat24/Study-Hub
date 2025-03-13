import 'package:flutter/material.dart';
import 'package:study_hub/core/constants/colors.dart';
import 'package:translator/translator.dart';

class TranslateScreen extends StatefulWidget {
  @override
  State<TranslateScreen> createState() => _TranslateWidgetState();
}

class _TranslateWidgetState extends State<TranslateScreen> {
  List<String> languages = [
    "Arabic",
    "German",
    "Italian",
    "Spanish",
    "English",
    "French",
  ];
  String? selectedLanguage = "English";
  String translatedText = "";
  String code = "ar";
  late TextEditingController textController;
  bool isTranslating = false; // Track translation progress

  final GoogleTranslator _translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Translation",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.buttonPrimary,
            fontSize: MediaQuery.of(context).size.width * 0.08,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  children: [
                    Text(
                      "Translate to",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: MediaQuery.of(context).size.width * 0.08,
                            color: Colors.black87,
                          ),
                          value: selectedLanguage,
                          items: languages.map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(
                                language,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLanguage = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF5F5F5), // Light grey background
                  ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: textController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Enter text to translate",
                          border: InputBorder.none,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.volume_up,
                              color: MyColors.buttonPrimary),
                          onPressed: () {
                            // Add text-to-speech function
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // Translate Button with Loading Indicator
                Center(
                  child: MaterialButton(
                    onPressed: isTranslating
                        ? null // Disable button while translating
                        : () async {
                            if (selectedLanguage == 'Arabic') {
                              code = "ar";
                            } else if (selectedLanguage == 'German') {
                              code = "de";
                            } else if (selectedLanguage == 'Italian') {
                              code = "it";
                            } else if (selectedLanguage == 'English') {
                              code = "en";
                            } else if (selectedLanguage == 'French') {
                              code = "fr";
                            } else {
                              code = "es";
                            }

                            setState(() {
                              isTranslating = true; // Start translation
                            });

                            await translate(code, textController.text);

                            setState(() {
                              isTranslating = false; // End translation
                            });
                          },
                    minWidth: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: MyColors.buttonPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: isTranslating
                        ? CircularProgressIndicator(
                            color: MyColors.buttonPrimary)
                        : Text(
                            "Translate",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF5F5F5),
                  ),
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Text(
                      translatedText,
                      textDirection: selectedLanguage == 'Arabic'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> translate(String code, String text) async {
    try {
      Translation translation = await _translator.translate(text, to: code);
      setState(() {
        translatedText = translation.text;
      });
    } catch (e) {
      print('Translation failed: $e');
      translatedText = "";
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/model_sum.dart';

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});

  @override
  State<SummarizeScreen> createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  late TextEditingController summarizeTextController;
  String summarizedText = "";
  final SummarizeService summarizeService = SummarizeService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    summarizeTextController = TextEditingController();
  }

  Future<void> summarize() async {
    final text = summarizeTextController.text;
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter some text to summarize")),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final response = await summarizeService.summarizeText(text);
      setState(() {
        summarizedText = response.summary;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to summarize text: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Summarization", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFF5F5F5),
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: summarizeTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Enter text to Summarize",
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Center(
                child: MaterialButton(
                  onPressed: isLoading ? null : summarize, //summarize method
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        )
                      : Text(
                          "Summarize",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFF5F5F5),
                ),
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: SelectableText(
                          summarizedText,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.copy, color: Colors.blue),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: summarizedText),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Text copied to clipboard")),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.settings_voice, color: Colors.blue),
                          onPressed: () {
                            // Navigate to text-to-speech screen
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

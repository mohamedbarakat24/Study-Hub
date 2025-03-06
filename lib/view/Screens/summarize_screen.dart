import 'package:flutter/material.dart';

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});

  @override
  State<SummarizeScreen> createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorText;

  void _validate_Input() {
    setState(() {
      if (_inputController.text.isEmpty) {
        _errorText = 'Please enter text to summarize.';
      } else {
        _errorText = null;

        ///*/// preform summarization function here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Summarizer'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 15),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _inputController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Enter text to summarize',
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
                onTap: _validate_Input,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: const Text(
                        'Summarize',
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _outputController,
                    maxLines: null,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Summarized text',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(16.0),
                    ),
                    scrollPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

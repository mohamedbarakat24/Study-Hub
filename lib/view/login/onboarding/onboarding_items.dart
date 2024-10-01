import 'onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "OCR",
        descriptions:
            " OCR will allow us to convert text embedded in images into machine-readable and editable text. This feature is essential for processing scanned documents, photos with text, or any image where text extraction is required",
        image: "assets/images/Onboarding/OCR.gif"),
    OnboardingInfo(
        title: "TTS",
        descriptions:
            "This feature utilizes Google's advanced neural network technologies, including the WaveNet model, to generate natural and human-like speech. The process involves text normalization, prosody analysis, and phonetic transcription to ensure that the synthesized speech is clear, accurate, and contextually appropriate.",
        image: "assets/images/Onboarding/Speech.gif"),
    OnboardingInfo(
        title: "NLP",
        descriptions:
            "This feature will automatically generate concise summaries from large blocks of text, utilizing both extractive and abstractive summarization methods. Extractive summarization selects key sentences directly from the text, while abstractive summarization generates new sentences that capture the essence of the content.",
        image: "assets/images/Onboarding/NLP.gif"),
  ];
}

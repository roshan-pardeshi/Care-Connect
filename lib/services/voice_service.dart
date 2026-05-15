import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  Future<void> initialize() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> speakInMarathi(String text) async {
    await _flutterTts.setLanguage('mr-IN');
    await _flutterTts.speak(text);
    await _flutterTts.setLanguage('en-US'); // Reset to default
  }

  Future<void> speakInHindi(String text) async {
    await _flutterTts.setLanguage('hi-IN');
    await _flutterTts.speak(text);
    await _flutterTts.setLanguage('en-US'); // Reset to default
  }

  Future<bool> initializeSpeech() async {
    return await _speechToText.initialize();
  }

  Future<void> startListening(Function(String) onResult) async {
    await _speechToText.listen(onResult: (result) {
      onResult(result.recognizedWords);
    });
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }
}
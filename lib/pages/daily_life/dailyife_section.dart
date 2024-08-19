import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../utilities/text_to_speech_service.dart';

class DailyLifeSection extends StatelessWidget {
  final Map<String, dynamic> sectionName;

  DailyLifeSection({required this.sectionName});

  final TextToSpeechService ttsService = TextToSpeechService();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            sectionName['section_ar'],
            style: TextStyle(fontFamily: "bahja", color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: sectionName['examples'].length,
          itemBuilder: (context, index) {
            final sentence = sectionName['examples'][index];
            return Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  sentence['ar'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  sentence['en'],
                  style: TextStyle(fontSize: 16),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () {
                    ttsService.speak(sentence['en']);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_tts/flutter_tts.dart';

import '../../utilities/text_to_speech_service.dart';

class SentencesTextToSpeesh extends StatefulWidget {
  final jsonFileName, sectionTitle;
  const SentencesTextToSpeesh(
      {super.key, this.jsonFileName, this.sectionTitle});

  @override
  State<SentencesTextToSpeesh> createState() => _SentencesTextToSpeeshState();
}

class _SentencesTextToSpeeshState extends State<SentencesTextToSpeesh> {
  List<dynamic> _items = [];

  final TextToSpeechService ttsService = TextToSpeechService();

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final jsonString = await rootBundle.rootBundle
        .loadString('assets/sentences/${widget.jsonFileName}');
    print('assets/sentences/${widget.jsonFileName}');

    final jsonResponse = json.decode(jsonString);

    String fileName = widget.jsonFileName;

    setState(() {
      _items = jsonResponse;
      // print(jsonResponse[fileNameWithoutExtension]);
    });
  }

  String removeFileExtension(String fileName) {
    return fileName.split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          widget.sectionTitle,
          style: TextStyle(fontFamily: "bahja", color: Colors.white),
        ),
      ),
      body: _items.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        item['english'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item['arabic'],
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.volume_up,
                              color: Colors.blue,
                              size: 30,
                            ),
                            onPressed: () => ttsService.speak(item['english']),
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.volume_up, color: Colors.green),
                          //   onPressed: () => _speak(item['arabic']),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              )),
    );
  }
}

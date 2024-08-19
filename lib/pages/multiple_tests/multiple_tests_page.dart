import 'package:english_sentences/pages/multiple_tests/quize_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class MultipletestsPage extends StatefulWidget {
  const MultipletestsPage({super.key});

  @override
  State<MultipletestsPage> createState() => _MultipletestsPageState();
}

class _MultipletestsPageState extends State<MultipletestsPage> {
  List<dynamic> _items = [];

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final jsonString = await rootBundle.rootBundle
        .loadString('assets/sentences/sentences.json');
    final jsonResponse = json.decode(jsonString);

    setState(() {
      _items = jsonResponse;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            "اختبارات متنوعة",
            style: TextStyle(fontFamily: "bahja", color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: _items.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
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
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizPage(
                                              jsonName: item['file_name'],
                                            )));
                              },
                              child: ListTile(
                                title: Text(
                                  "اختبارات حول ${item['title_arabic']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "ابدأ الاختبار",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}

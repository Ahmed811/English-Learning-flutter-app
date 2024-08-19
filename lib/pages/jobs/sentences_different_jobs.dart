import 'package:english_sentences/pages/jobs/sentences_text_to_speesh.dart';
import 'package:english_sentences/providers/job_section_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SentencesInDifferentJobs extends StatelessWidget {
  const SentencesInDifferentJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final sentencesProvider = Provider.of<JobSectionProvider>(context);

    // Load the data once when the widget is built
    if (sentencesProvider.filteredItems.isEmpty) {
      sentencesProvider.loadJson();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'اهم الجمل في الوظائف المختلفة',
            style: TextStyle(fontFamily: "bahja", color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  sentencesProvider.filterItems(value);
                },
                decoration: InputDecoration(
                  labelText: 'ابحث عن جملة',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: sentencesProvider.filteredItems.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: sentencesProvider.filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = sentencesProvider.filteredItems[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SentencesTextToSpeesh(
                                          jsonFileName: item['file_name'],
                                          sectionTitle: item["title_arabic"],
                                        )));
                          },
                          child: AnimatedContainer(
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
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title_english'] ?? "not found",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    item['title_arabic'] ?? "not found",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "bahja"),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                item['description_arabic'] ?? "not found",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(),
                              ),
                              trailing: Icon(Icons.arrow_forward),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

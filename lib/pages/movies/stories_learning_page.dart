import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../providers/audio_player_provider.dart';

class StoriesListPage extends StatefulWidget {
  @override
  _StoriesListPageState createState() => _StoriesListPageState();
}

class _StoriesListPageState extends State<StoriesListPage> {
  late Future<List<Stories>> stories;
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;
  @override
  void initState() {
    super.initState();
    stories = loadStories();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<List<Stories>> loadStories() async {
    final jsonString =
        await rootBundle.rootBundle.loadString('assets/stories.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Stories.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_connectionStatus.toString() == "InternetStatus.disconnected") {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("لا يوجد اتصال بالانترنت!!"),
              SizedBox(
                height: 5,
              ),
              Text("لتشغيل الافلام تحتاج الي الاتصال بالانترنت!!"),
            ],
          ),
        ),
      );
    }
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'قصص صوتية مترجمة',
            style: TextStyle(fontFamily: "bahja", color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<Stories>>(
          future: stories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final stories = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final movie = stories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(stories: movie),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailPage(stories: movie),
                          ),
                        );
                      },
                      hoverColor: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            child: ListTile(
                                trailing: Text(
                                  "اسم القصة",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: "bahja"),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Image.network(
                                  height: 150,
                                  movie.storyThumb,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  movie.storyNameEnglish,
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: stories.length,
              );
            }
          },
        ),
      );
    }
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              'قصص صوتية مترجمة',
              style: TextStyle(fontFamily: "bahja", color: Colors.white),
            ),
          ),
          body: FutureBuilder<List<Stories>>(
            future: stories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final movies = snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final story = movies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailPage(stories: story),
                          ),
                        );
                      },
                      child: Card(
                          elevation: 10,
                          child: ListTile(
                            title: Text(
                              story.storyNameEnglish,
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              story.storyNameArabic,
                              style: TextStyle(fontFamily: "bahja"),
                            ),
                            trailing: SizedBox(
                              height: 150,
                              width: 150,
                              child: FastCachedImage(
                                url: story.storyThumb,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * .3,
                                fadeInDuration: const Duration(seconds: 1),
                                errorBuilder: (context, exception, stacktrace) {
                                  return Text(stacktrace.toString());
                                },
                                loadingBuilder: (context, progress) {
                                  return Container(
                                    color: Colors.deepOrange,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        if (progress.isDownloading &&
                                            progress.totalBytes != null)
                                          SizedBox(
                                              width: 120,
                                              height: 120,
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                              )),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )),
                    );
                  },
                  itemCount: movies.length,
                );
              }
            },
          ),
        ));
  }
}

class MovieDetailPage extends StatefulWidget {
  final Stories stories;

  MovieDetailPage({required this.stories});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late AudioPlayerProvider audioProvider;
  @override
  void initState() {
    super.initState();
    audioProvider = AudioPlayerProvider();
  }

  @override
  void dispose() {
    audioProvider.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'تعلم الانجليزية من القصص المسموعة',
            style: TextStyle(color: Colors.white, fontFamily: 'bahja'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Story: ${widget.stories.storyNameEnglish}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Image.network(
                  widget.stories.storyThumb,
                  fit: BoxFit.cover,
                  height: 200,
                  width: 300,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: widget.stories.sentences
                      .map((example) => ExampleSentence(
                            en: example['en']!,
                            ar: example['ar']!,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ChangeNotifierProvider<AudioPlayerProvider>.value(
      value: audioProvider,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'قصص صوتية',
              style: TextStyle(fontFamily: 'bahja'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Story: ${widget.stories.storyNameEnglish}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Image.network(
                    widget.stories.storyThumb,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 300,
                  ),
                ),

                //////////////////////////////////////////
                if (audioProvider.isPlaying || audioProvider.isPaused)
                  ProgressBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (audioProvider.isPlaying || audioProvider.isPaused)
                      ProgressBar(),
                    Consumer<AudioPlayerProvider>(
                      builder: (context, audioProvider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(audioProvider.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              onPressed: () {
                                if (audioProvider.isPlaying) {
                                  audioProvider.pause();
                                } else {
                                  audioProvider.play(widget.stories.storyUrl);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.stop),
                              onPressed: () => audioProvider.stop(),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                /////////////////////////////////////////
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: widget.stories.sentences
                        .map((example) => ExampleSentence(
                              en: example['en']!,
                              ar: example['ar']!,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExampleSentence extends StatelessWidget {
  final String en;
  final String ar;

  ExampleSentence({required this.en, required this.ar});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'English: $en',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Arabic: $ar',
              style: TextStyle(
                  fontSize: 18, color: Colors.grey[600], fontFamily: 'bahja'),
            ),
          ],
        ),
      ),
    );
  }
}

class Stories {
  final String storyUrl;
  final String storyThumb;
  final String storyNameEnglish;
  final String storyNameArabic;
  final List<Map<String, String>> sentences;

  Stories({
    required this.storyUrl,
    required this.storyThumb,
    required this.storyNameEnglish,
    required this.storyNameArabic,
    required this.sentences,
  });

  factory Stories.fromJson(Map<String, dynamic> json) {
    return Stories(
      storyUrl: json['story_url'],
      storyThumb: json['story_image'],
      storyNameEnglish: json['story_name_en'],
      storyNameArabic: json['story_name_ar'],
      sentences: List<Map<String, String>>.from(
        json['sentences'].map((sentence) => Map<String, String>.from(sentence)),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);
    final progress = audioProvider.duration.inMilliseconds > 0
        ? audioProvider.position.inMilliseconds /
            audioProvider.duration.inMilliseconds
        : 0.0;

    return Column(
      children: [
        Slider(
          value: progress,
          onChanged: (value) {},
          min: 0.0,
          max: 1.0,
        ),
        Text(
          '${audioProvider.position.toString().split('.').first} / ${audioProvider.duration.toString().split('.').first}',
        ),
      ],
    );
  }
}

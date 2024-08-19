import 'package:english_sentences/pages/multiple_tests/quize_page.dart';
import 'package:english_sentences/pages/test_di.dart';
import 'package:english_sentences/providers/audio_player_provider.dart';
import 'package:english_sentences/providers/daily_life_provider.dart';
import 'package:english_sentences/providers/job_section_provider.dart';
import 'package:english_sentences/web_version/check_user_pass_web.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'web_version/home_page_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (_) => DailyLifeProvider()),
        ChangeNotifierProvider(create: (_) => JobSectionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'English Sentences',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: Directionality(textDirection: TextDirection.rtl, child: HomePage()),
        home: Directionality(
            // textDirection: TextDirection.rtl, child: HomeScreenWeb()),
            textDirection: TextDirection.rtl,
            // child: kIsWeb ? HomeScreenWeb() : HomePage()),
            child: kIsWeb ? CheckUserAndPass() : HomePage()),
      ),
    );
  }
}

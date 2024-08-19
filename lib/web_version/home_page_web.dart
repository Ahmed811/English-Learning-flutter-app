import 'package:english_sentences/pages/check_connect.dart';
import 'package:english_sentences/pages/daily_life/daily_life_sentences.dart';
import 'package:english_sentences/pages/movies/stories_learning_page.dart';
import 'package:english_sentences/pages/movies/stories_learning_page.dart';
import 'package:english_sentences/pages/multiple_tests/multiple_tests_page.dart';
import 'package:english_sentences/pages/dictionary_page/oxford_dictionary.dart';
import 'package:english_sentences/pages/jobs/sentences_different_jobs.dart';
import 'package:english_sentences/pages/setting_page.dart';
import 'package:english_sentences/pages/test_di.dart';
import 'package:english_sentences/widgets/custom_buttom_web.dart';
import 'package:english_sentences/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../home_page.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  bool useSystemCursor = false;
  Axis axis = Axis.vertical;
  // Controllers
  late ScrollController _scrollController;
  void toggleCursor() {
    setState(() {
      useSystemCursor = !useSystemCursor;
    });
  }

  @override
  void initState() {
    // initialize scroll controllers
    // toggleCursor();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: buildScrollingView(axis, _scrollController),
    );
  }
}

Widget buildScrollingView(Axis axis, ScrollController controller) {
  bool useSystemCursor = false;
  return ImprovedScrolling(
    scrollController: controller,
    onScroll: (scrollOffset) => debugPrint(
      'Scroll offset: $scrollOffset',
    ),
    onMMBScrollStateChanged: (scrolling) => debugPrint(
      'Is scrolling: $scrolling',
    ),
    onMMBScrollCursorPositionUpdate: (localCursorOffset, scrollActivity) =>
        debugPrint(
      'Cursor position: $localCursorOffset\n'
      'Scroll activity: $scrollActivity',
    ),
    enableMMBScrolling: true,
    enableKeyboardScrolling: true,
    enableCustomMouseWheelScrolling: true,
    mmbScrollConfig: MMBScrollConfig(
      customScrollCursor:
          useSystemCursor ? null : const DefaultCustomScrollCursor(),
    ),
    keyboardScrollConfig: KeyboardScrollConfig(
      homeScrollDurationBuilder: (currentScrollOffset, minScrollOffset) {
        return const Duration(milliseconds: 100);
      },
      endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
        return const Duration(milliseconds: 2000);
      },
    ),
    customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
      scrollAmountMultiplier: 4.0,
      scrollDuration: Duration(milliseconds: 350),
    ),
    child: ScrollConfiguration(
      behavior: const CustomScrollBehaviour(),
      child: GridView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: axis,
        padding: const EdgeInsets.all(24.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisExtent: 250.0,
        ),
        children: [
          const CustomButton(
            buttonTitle: "اهم الجمل في الحياة اليومية",
            iconName: "sunrise.json",
            screen: DailyLifeSentences(),
          ),
          const CustomButton(
            buttonTitle: "اهم الجمل في الوظائف المختلفة",
            iconName: "jobs.json",
            screen: SentencesInDifferentJobs(),
          ),
          CustomButton(
            buttonTitle: "قصص صوتية مترجمة",
            iconName: "movie.json",
            screen: StoriesListPage(),
          ),
          const CustomButton(
            buttonTitle: "قاموس انجليزي عربي",
            iconName: "dictionary.json",
            screen: OxfordDictionary(),
          ),
          const CustomButton(
            buttonTitle: "اختبارات متعددة",
            iconName: "test.json",
            screen: MultipletestsPage(),
          ),
          const CustomButton(
            buttonTitle: "اعدادات التطبيق",
            iconName: "setting.json",
            screen: SettingPage(),
          ),
        ],
      ),
    ),
  );
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:english_sentences/pages/movies/stories_learning_page.dart';
import 'package:english_sentences/web_version/home_page_web.dart';
import 'package:english_sentences/pages/check_connect.dart';
import 'package:english_sentences/pages/daily_life/daily_life_sentences.dart';
import 'package:english_sentences/pages/movies/stories_learning_page.dart';
import 'package:english_sentences/pages/multiple_tests/multiple_tests_page.dart';
import 'package:english_sentences/pages/dictionary_page/oxford_dictionary.dart';
import 'package:english_sentences/pages/jobs/sentences_different_jobs.dart';
import 'package:english_sentences/pages/setting_page.dart';
import 'package:english_sentences/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class HomePage extends StatelessWidget {
  final colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = const TextStyle(
      shadows: [
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,
          color: Colors.orange,
        ),
        Shadow(
          offset: Offset(-2.0, -2.0),
          blurRadius: 3.0,
          color: Colors.deepOrange,
        ),
      ],
      fontSize: 35.0,
      fontFamily: 'bahja',
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double containerHeight = constraints.maxWidth < 600 ? 240 : 300;
          int crossAxisCount = constraints.maxWidth < 600 ? 2 : 5;

          return constraints.maxWidth < 600
              ? Column(
                  children: [
                    Container(
                      height: containerHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/hero.png",
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              '5000',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                            ),
                            ColorizeAnimatedText(
                              'جملة انجليزية',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                            ),
                            ColorizeAnimatedText(
                              textDirection: TextDirection.rtl,
                              '5000 جملة انجليزية',
                              textStyle: colorizeTextStyle,
                              speed: Duration(seconds: 1),
                              colors: colorizeColors,
                            ),
                          ],
                          isRepeatingAnimation: true,
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                        scrollDirection: Axis.vertical,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: crossAxisCount,
                        children: [
                          CustomButton(
                            buttonTitle: "اهم الجمل في الحياة اليومية",
                            iconName: "sunrise.json",
                            screen: DailyLifeSentences(),
                          ),
                          CustomButton(
                            buttonTitle: "اهم الجمل في الوظائف المختلفة",
                            iconName: "jobs.json",
                            screen: SentencesInDifferentJobs(),
                          ),
                          CustomButton(
                            buttonTitle: "قصص صوتية مترجمة",
                            iconName: "movie.json",
                            screen: StoriesListPage(),
                          ),
                          CustomButton(
                            buttonTitle: "قاموس انجليزي عربي",
                            iconName: "dictionary.json",
                            screen: OxfordDictionary(),
                          ),
                          CustomButton(
                            buttonTitle: "اختبارات متعددة",
                            iconName: "test.json",
                            screen: MultipletestsPage(),
                          ),
                          CustomButton(
                            buttonTitle: "حول التطبيق",
                            iconName: "setting.json",
                            screen: SettingPage(),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : HomeScreenWeb();
        },
      ),
    );
  }
}
//
// class TestScroll extends StatefulWidget {
//   const TestScroll({super.key});
//
//   @override
//   State<TestScroll> createState() => _TestScrollState();
// }
//
// class _TestScrollState extends State<TestScroll> {
//   // Controllers
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     // initialize scroll controllers
//     _scrollController = ScrollController();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Web Smooth Scroll'),
//       ),
//       body: WebSmoothScroll(
//         controller: _scrollController,
//         scrollOffset: 100,
//         animationDuration: 600,
//         curve: Curves.easeInOutCirc,
//         child: SingleChildScrollView(
//           controller: _scrollController,
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 child: GridView.count(
//                   padding: EdgeInsets.all(8),
//                   scrollDirection: Axis.vertical,
//                   crossAxisSpacing: 2,
//                   mainAxisSpacing: 2,
//                   crossAxisCount: 4,
//                   children: [
//                     CustomButton(
//                       buttonTitle: "اهم الجمل في الحياة اليومية",
//                       iconName: "sunrise.json",
//                       screen: DailyLifeSentences(),
//                     ),
//                     CustomButton(
//                       buttonTitle: "اهم الجمل في الوظائف المختلفة",
//                       iconName: "jobs.json",
//                       screen: SentencesInDifferentJobs(),
//                     ),
//                     CustomButton(
//                       buttonTitle: "اهم الجمل في الافلام",
//                       iconName: "movie.json",
//                       screen: MovieListPage(),
//                     ),
//                     CustomButton(
//                       buttonTitle: "قاموس اكسفوورد",
//                       iconName: "dictionary.json",
//                       screen: OxfordDictionary(),
//                     ),
//                     CustomButton(
//                       buttonTitle: "اختبارات متعددة",
//                       iconName: "test.json",
//                       screen: MultipletestsPage(),
//                     ),
//                     CustomButton(
//                       buttonTitle: "اختبارات متعددة",
//                       iconName: "test.json",
//                       screen: MultipletestsPage(),
//                     ),
//                     CustomButton(
//                       buttonTitle: "اعدادات التطبيق",
//                       iconName: "setting.json",
//                       screen: CheckConnect(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildScrollableList() => Column(
//       children: List.generate(
//         50,
//         (index) => Container(
//           height: 100,
//           margin: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 120.0),
//           color: Colors.red,
//         ),
//       ),
//     );

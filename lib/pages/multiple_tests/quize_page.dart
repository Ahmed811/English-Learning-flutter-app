import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'multiple_tests_page.dart';

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question(
      {required this.question,
      required this.options,
      required this.correctAnswer});
}

class QuizPage extends StatefulWidget {
  final jsonName;

  const QuizPage({super.key, required this.jsonName});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Question> questions; // قائمة الأسئلة
  int currentQuestionIndex = 0; // مؤشر السؤال الحالي
  int score = 0; // عدد النقاط
  bool isLoading = true; // حالة التحميل

  @override
  void initState() {
    super.initState();
    loadQuestions(); // تحميل الأسئلة من الأصول
  }

  // دالة لتحميل الأسئلة من ملف JSON في الأصول
  Future<void> loadQuestions() async {
    final String jsonString =
        await rootBundle.loadString('assets/sentences/${widget.jsonName}');
    setState(() {
      questions = generateQuestions(jsonString);
      questions.shuffle();
      questions = questions.take(100).toList();
      isLoading = false; // انتهى التحميل
    });
  }

  // دالة لتوليد الأسئلة من JSON
  List<Question> generateQuestions(String jsonString) {
    final List<dynamic> data = jsonDecode(jsonString);
    final Random random = Random();
    List<Question> questions = [];

    for (var item in data) {
      final String question = item['english'];
      final String correctAnswer = item['arabic'];

      Set<int> usedIndices = {data.indexOf(item)};
      List<String> options = [correctAnswer];

      // اختيار 3 خيارات خاطئة عشوائية
      while (options.length < 4) {
        final int optionIndex = random.nextInt(data.length);
        if (!usedIndices.contains(optionIndex)) {
          options.add(data[optionIndex]['arabic']);
          usedIndices.add(optionIndex);
        }
      }

      options.shuffle(); // خلط الخيارات
      questions.add(Question(
          question: question, options: options, correctAnswer: correctAnswer));
    }

    return questions;
  }

  // دالة للتحقق من الإجابة
  void checkAnswer(String selectedAnswer) {
    final isCorrect =
        selectedAnswer == questions[currentQuestionIndex].correctAnswer;

    if (isCorrect) {
      score++; // زيادة النقاط إذا كانت الإجابة صحيحة
    }

    // إظهار إشعار بالإجابة
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
        content: Text(isCorrect
            ? 'Good job!'
            : 'The correct answer was: ${questions[currentQuestionIndex].correctAnswer}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // الانتقال إلى السؤال التالي أو عرض النتيجة النهائية
              if (currentQuestionIndex < questions.length - 1) {
                setState(() {
                  currentQuestionIndex++;
                });
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => ResultPage(
                          score: score, totalQuestions: questions.length)),
                );
              }
            },
            child: Text('Next'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'Quiz',
            style: TextStyle(fontFamily: "bahja", color: Colors.white),
          ),
        ),
        body: Center(
          child:
              CircularProgressIndicator(), // عرض مؤشر تحميل أثناء تحميل الأسئلة
        ),
      );
    }

    final question = questions[currentQuestionIndex]; // السؤال الحالي

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "اختر الترجمة العربية الصحيحة",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: "bahja",
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}', // عرض رقم السؤال الحالي
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              Text(
                question.question, // عرض نص السؤال
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              // عرض الخيارات كأزرار
              for (var option in question.options)
                ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  child: Text(option),
                ),
              SizedBox(height: 20),
              Text(
                'Score: $score', // عرض عدد النقاط
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// صفحة عرض النتيجة النهائية
class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Result'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score', // عنوان النتيجة
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '$score / $totalQuestions', // عرض النتيجة
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => MultipletestsPage()),
                  );
                },
                child:
                    Text('العودة الي قائمة الاختبارات'), // زر لإعادة المحاولة
              ),
            ],
          ),
        ),
      ),
    );
  }
}

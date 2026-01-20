import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'app_Brain.dart';

void main() {
  runApp(ExamApp());
}

class ExamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('اختبار'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ExamPage(),
        ),
      ),
    );
  }
}

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  AppBrain appBrain = AppBrain();
  List<Widget> answerResult = [];
  int rightAnswers = 0;

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = appBrain.getCorrectAnswer();
    setState(() {
      if (userAnswer == correctAnswer) {
        rightAnswers++;
        answerResult.add(
          const Padding(
            padding: EdgeInsets.all(3.0),
            child: Icon(
              Icons.thumb_up,
              color: Colors.green,
            ),
          ),
        );
      } else {
        answerResult.add(
          const Padding(
            padding: EdgeInsets.all(3.0),
            child: Icon(
              Icons.thumb_down,
              color: Colors.red,
            ),
          ),
        );
      }

      if (appBrain.isFinished() == true) {
        String alertTitle;
        String alertDesc;
        AlertType alertType;
        if (rightAnswers == appBrain.getQuestionsCount()) {
          alertTitle = 'الف مبروك!';
          alertDesc = 'لقد جاوبت على جميع الاسئله بشكل صحيح';
          alertType = AlertType.success;
        } else {
          alertTitle = 'انتهى الاختبار';
          alertDesc =
              'لقد أجبت على $rightAnswers من ${appBrain.getQuestionsCount()} أسئلة بشكل صحيح';
          alertType = AlertType.info;
        }

        Alert(
          context: context,
          type: alertType,
          title: alertTitle,
          desc: alertDesc,
          buttons: [
            DialogButton(
              child: const Text(
                "البدء من جديد",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  appBrain.reset();
                  answerResult.clear();
                  rightAnswers = 0;
                });
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        appBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: answerResult,
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Image.asset(appBrain.getQuestionImage()),
              const SizedBox(
                height: 20,
              ),
              Text(
                appBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'صح',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'غلط',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}

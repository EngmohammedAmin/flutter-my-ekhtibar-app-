// import 'dart:html';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'app_brain.dart';

AppBrain appBrain = AppBrain();
void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          backgroundColor: Colors.cyan[900],
          title: const Text('Exam'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
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
  List<Widget> answerResult = [];

  int rightAnswer = 0;
  int allQuestions = appBrain.questionLenght() + 1;
  void checkAnswer(bool whatUserPicked) {
    // appBrain.questionGroup[questionNumber].questionAnswer = true;
    bool correctAnswer = appBrain.getQuestionAnswer();
    setState(() {
      if (whatUserPicked == correctAnswer) {
        rightAnswer++;
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
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              Icons.thumb_down,
              color: Colors.red[500],
            ),
          ),
        );
      }
      if (appBrain.isFinished() == true) {
        // window.alert("لقد أجبت على $rightAnswer أسئلة صحيحة من أصل 7");
        Alert(
          style: AlertStyle(
            animationType: AnimationType.fromTop,
            isCloseButton: true,
            isOverlayTapDismiss: false,
            descStyle: const TextStyle(fontWeight: FontWeight.bold),
            descTextAlign: TextAlign.center,
            animationDuration: Duration(milliseconds: 500),
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: const BorderSide(
                color: Colors.grey,
              ),
            ),
            titleStyle: const TextStyle(
              color: Colors.red,
            ),
            alertAlignment: Alignment.topCenter,
          ),
          context: context,
          type: AlertType.error,
          title: "انتهاء الاختبار",
          desc: "لقد أجبت على $rightAnswer أسئلة صحيحة من أصل $allQuestions",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "ابدأ من جديد",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ).show();

        appBrain.reset();

        answerResult = [];

        rightAnswer = 0;
      } else {
        appBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var img = questionNumber + 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: answerResult,
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              // Image.asset('images/image-$img.jpg'),
              Image.asset(appBrain.getQuestionImage()),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  appBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade900),
              ),
              child: const Text(
                ' صــــــــح',
                style: TextStyle(color: Colors.white, fontSize: 18),
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
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepOrange),
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                ' خطــــــــــأ',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

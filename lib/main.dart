import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  QuestionBank questionBank = QuestionBank();

  void checkAnswer(bool userPickAnswer) {
    bool correctAnswer = questionBank.getQuestionAnswer();
    setState(() {
      if (questionBank.isFinished() == true) {
        Alert(
                context: context,
                title: "Finished",
                desc: "You have reached the end.")
            .show();
        questionBank.reset();
        scoreKeeper = [];
      } else {
        if (userPickAnswer = correctAnswer) {
          print('User right');
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          print('User wrong');
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        questionBank.getQuestionNumber();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                questionBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gruppo',
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green[900],
                    textStyle: const TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () {
                  print('true');
                  checkAnswer(true);
                },
                child: const Text(
                  'True',
                  style: TextStyle(
                    fontFamily: 'Waterfall',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red[900],
                ),
                onPressed: () {
                  print('false');
                  checkAnswer(false);
                },
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Waterfall',
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

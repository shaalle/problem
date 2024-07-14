import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Map<String, Object>> _questions = [];
  int _currectQuestionIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  void _loadQuestion() {
    _questions = [
      {
        'question': 'Kumaa ahaa khaliifkii 1aaad ee muslimiinta ?',
        'answers': ['Abuubakar', 'Cumar', 'Cali'],
        'correctAnswer': 'Abuubakar',
      },
      {
        'question': '2 + 5 ?',
        'answers': ['9', '7', '15'],
        'correctAnswer': '7',
      },
      {
        'question': '5 * 5 ?',
        'answers': ['25', '15', '18'],
        'correctAnswer': '25',
      },
      {
        'question': '15 - 7 ?',
        'answers': ['5', '8', '9'],
        'correctAnswer': '8',
      }
    ];
  }

  void _checkAnswers(String answer) {
    if (answer == _questions[_currectQuestionIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }
    if (_currectQuestionIndex < _questions.length - 1) {
      _nextQuestion();
    } else {
      _showScore();
    }
  }

  void _resetQuiz() {
    setState(() {
      _currectQuestionIndex = 0;
      _score = 0;
    });
  }

  void _nextQuestion() {
    _currectQuestionIndex++;
  }

  void _showScore() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Final Quizes'),
              content: Text('Total scores is $_score'),
              actions: [
                TextButton(
                    onPressed: () {
                      _resetQuiz();
                      Navigator.pop(context);
                    },
                    child: const Text('Reset Quiz'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildQuestions(),
            _buildAnswers(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestions() {
    return Text(_questions[_currectQuestionIndex]['question'] as String);
  }

  Widget _buildAnswers() {
    List<String> answers =
        (_questions[_currectQuestionIndex]['answers'] as List<String>);
    return Column(
      children: answers
          .map((answer) => ElevatedButton(
              onPressed: () {
                _checkAnswers(answer);
              },
              child: Text(answer)))
          .toList(),
    );
  }
}

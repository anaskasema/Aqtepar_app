import 'qustion.dart';

class AppBrain {
  int _questionNumber = 0;

  final List<Question> _questionGroup = [
    Question(
      questionText: 'عدد الكواكب في المجموعة الشمسية هو ثمانية كواكب',
      questionImage: 'images/image-1.jpg',
      questionAnswer: true,
    ),
    Question(
      questionText: 'القطط هي حيوانات لاحمة',
      questionImage: 'images/image-2.jpg',
      questionAnswer: true,
    ),
    Question(
      questionText: 'الصين موجودة في القارة الأفريقية',
      questionImage: 'images/image-3.jpg',
      questionAnswer: false,
    ),
    Question(
      questionText: 'الأرض مسطحة وليست كروية',
      questionImage: 'images/image-4.jpg',
      questionAnswer: false,
    ),
    Question(
      questionText: 'بإمكان الإنسان البقاء على قيد الحياة بدون أكل اللحوم',
      questionImage: 'images/image-5.jpg',
      questionAnswer: true,
    ),
    Question(
      questionText: 'الشمس تدور حول الأرض والأرض تدور حول القمر',
      questionImage: 'images/image-6.jpg',
      questionAnswer: false,
    ),
    Question(
      questionText: 'الحيوانات لا تشعر بالألم',
      questionImage: 'images/image-7.jpg',
      questionAnswer: false,
    ),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionGroup.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionGroup[_questionNumber].questionText;
  }

  String getQuestionImage() {
    return _questionGroup[_questionNumber].questionImage;
  }

  bool getCorrectAnswer() {
    return _questionGroup[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    return _questionNumber >= _questionGroup.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }

  int getQuestionsCount() {
    return _questionGroup.length;
  }
}

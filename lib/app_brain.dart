import 'question.dart';
// import 'dart:html';

class AppBrain {
  int _questionNumber = 0;
  List<Question> _questionGroup = [
    Question(
      q: 'عدد الكواكب في المجموعة الشمسية هو 8 كواكب',
      i: 'images/image-1.jpg',
      a: true,
    ),
    Question(
      q: 'القطط من فئة اللحميات ',
      i: 'images/image-2.jpg',
      a: true,
    ),
    Question(
      q: 'الصين تقع في قارة أفريقيا',
      i: 'images/image-3.jpg',
      a: false,
    ),
    Question(
      q: 'الأرض مسطحة وليست كروية',
      i: 'images/image-4.jpg',
      a: false,
    ),
    Question(
      q: 'يستطيع الإنسان العيش بدون لحوم',
      i: 'images/image-5.jpg',
      a: true,
    ),
    Question(
      q: 'الشمس تدور حول ألأرض',
      i: 'images/image-6.jpg',
      a: false,
    ),
    Question(
      q: 'الحيوانات لاتشعر بالألم',
      i: 'images/image-7.jpg',
      a: false,
    ),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionGroup.length - 1) {
      _questionNumber++;
    } else {
      _questionNumber = 0;
    }
  }

  String getQuestionText() {
    return _questionGroup[_questionNumber].questionText;
  }

  String getQuestionImage() {
    return _questionGroup[_questionNumber].questionImage;
  }

  bool getQuestionAnswer() {
    return _questionGroup[_questionNumber].questionAnswer;
  }

  int questionLenght() {
    return _questionGroup.length - 1;
  }

//bb
  bool isFinished() {
    if (_questionNumber >= _questionGroup.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}

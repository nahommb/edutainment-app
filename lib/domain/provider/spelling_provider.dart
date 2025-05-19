import 'package:edutainment_app/models/spelling_puzzle_model.dart';
import 'package:edutainment_app/repository/quiz_repository.dart';
import 'package:flutter/material.dart';

class SpellingProvider extends ChangeNotifier {
  QuizRepository repository = QuizRepository();
  int currentIndex = -1;
  SpellingPuzzleModel? currentModel;
  bool isSubmitAll = false;
  bool isSubmited = false;
  List<SpellingPuzzleModel> spellingPuzzleModelList = [];
  List<SpellingOptionModel> currentSpelling = [];
  List<SpellingOptionModel> selectedSpelling = [];
  int get getCurrentIndex => currentIndex;
  int correctAnswer = 0;

  setCurrentSpelling() {
    currentIndex++;
    currentModel = spellingPuzzleModelList[currentIndex];
    currentSpelling = getSpelling();
    selectedSpelling = getTheSizeOfAnswer(); // List of 5 empty strings
    isSubmitAll = false;
    isSubmited = false;
    notifyListeners();
  }

  set setIsSubmited(bool value) {
    isSubmited = value;
    if (checkAnswer()) {
      correctAnswer++;
    }
    notifyListeners();
  }

  Future fetchQuestion() async {
    try {
      currentIndex = -1;
      currentModel = null;
      currentSpelling = [];
      selectedSpelling = [];
      spellingPuzzleModelList = [];
      isSubmitAll = false;
      isSubmited = false;
      notifyListeners();
      var res = await repository.getSpellingPuzzle();
      res.fold(
        (l) {
          print(l);
        },
        (r) {
          spellingPuzzleModelList = r;
          setCurrentSpelling();
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  addToSelected(int index, int selectedIndex) {
    print(selectedIndex);

    if (selectedSpelling[index].selectedOption != null) {
      currentSpelling[selectedSpelling[index]
          .selectedOption!] = SpellingOptionModel(
        isVisable: true,
        option: currentSpelling[selectedSpelling[index].selectedOption!].option,
      );
      selectedSpelling[index] = SpellingOptionModel(
        isVisable: true,
        option: currentSpelling[selectedIndex].option,
        selectedOption: selectedIndex,
      );
    } else {
      selectedSpelling[index] = SpellingOptionModel(
        isVisable: true,
        option: currentSpelling[selectedIndex].option,
        selectedOption: selectedIndex,
      );
    }
    currentSpelling[selectedIndex].isVisable = false;
    isSubmitAll = selectedSpelling.every((item) => item.selectedOption != null);
    notifyListeners();
    print(selectedSpelling[1].option);
  }

  List<SpellingOptionModel> getSpelling() {
    List<String> sp =
        (currentModel!.answer.split('') + currentModel!.option.split(''));
    sp.shuffle();
    List<SpellingOptionModel> option = [];
    for (var s in sp) {
      option.add(SpellingOptionModel(isVisable: true, option: s));
    }
    return option;
  }

  List<SpellingOptionModel> getTheSizeOfAnswer() {
    List<SpellingOptionModel> answer = List.filled(
      currentModel!.answer.length,
      SpellingOptionModel(isVisable: true, option: ""),
    );
    return answer;
  }

  bool checkAnswer() {
    List<String> sp = currentModel!.answer.split('');
    for (int i = 0; i < sp.length; i++) {
      if (selectedSpelling[i].option != sp[i]) {
        return false;
      }
    }
    return true;
  }
}

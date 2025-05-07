
import 'package:edutainment_app/models/story_model.dart';
import 'package:edutainment_app/repository/story_repository.dart';
import 'package:flutter/cupertino.dart';

class StoryProvider with ChangeNotifier {

  List<StoryModel> _story = [] ;
  List<StoryModel> get story => _story;

  Future<void> getStory()async {
    final result = await StoryRepository().getStory();
    result.fold((l){
      print(l);
    }, (r){
      _story = r;
      print(_story[0].title);
    });
    notifyListeners();
  }
}
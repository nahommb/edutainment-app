
import 'package:edutainment_app/models/story_model.dart';
import 'package:edutainment_app/repository/story_repository.dart';
import 'package:flutter/cupertino.dart';

class StoryProvider with ChangeNotifier {

  List<StoryModel> _story = [] ;
  List<StoryModel> get story => _story;

  Future<void> getStory()async {
    final result = await StoryRepository().getStory();
    result.fold((l){
      print('errorrrrrrr 1');
      print(l);
    }, (r){
      _story = r;
      print('leeeeeeeee eeeeeeeeeetrrrrrrrrrrro');
      print(r);
    });
    notifyListeners();
  }
}
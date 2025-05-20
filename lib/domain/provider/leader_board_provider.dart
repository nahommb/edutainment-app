
import 'package:edutainment_app/models/leaderboard_model.dart';
import 'package:edutainment_app/repository/leaderboard_repository.dart';
import 'package:flutter/foundation.dart';

class LeaderBoardProvider with ChangeNotifier {

  List<Leaderboard> _globalLeader = [];
  List<Leaderboard> get globalLeader =>_globalLeader;
  int _your_rank = 0;
  int get your_rank =>_your_rank;
  int  _your_score = 0;

  int get your_score => _your_score;
  int _child_rank = 0;
  int get child_rank => _child_rank;

  int _child_score = 0;
  int get child_score => _child_score;

Future<void> getLeaderBoard({email}) async{
  
  // final result =  await LeaderboardRepository().setLeaderboard(correctAnswer: 4, wrongAnswer: 2, quizId: 2);
 final result = await LeaderboardRepository().getLaderbaord();

  result.fold((l){
    print(l);
  }, (r){

    _globalLeader = r.globalLeaderboard;
    print('check leader ${_globalLeader[0].totalCorrect}');
     int index = _globalLeader.indexWhere((leader) => leader.email == email);
    _your_rank = index + 1;
    _your_score = int.parse(_globalLeader[index].totalCorrect);
    print('your rank is $_your_rank');
    print('check leader ${_globalLeader[0].name}');
  });
 notifyListeners();
}

Future<void> setLeaderBoared({correctAnswer,wrongAnswer,quizId}) async{
  final result = await LeaderboardRepository().setLeaderboard(correctAnswer: correctAnswer, wrongAnswer: wrongAnswer, quizId: quizId);
  result.fold((l){}, (r){

  });

}

Future<void> getChildrenRankAndScore(email) async{
  final result = await LeaderboardRepository().getLaderbaord();

  result.fold((l){
    print(l);
  }, (r){

    _globalLeader = r.globalLeaderboard;
    // print('check leader ${_globalLeader[0].totalCorrect}');
    int index = _globalLeader.indexWhere((leader) => leader.email == email);
     _child_rank = index + 1;
     _child_score= int.parse(_globalLeader[index].totalCorrect);
    // print('your rank is $_your_rank');
    // print('check leader ${_globalLeader[0].name}');
  });
  notifyListeners();
}
}
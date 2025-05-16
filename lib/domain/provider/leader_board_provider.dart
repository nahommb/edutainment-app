
import 'package:edutainment_app/models/leaderboard_model.dart';
import 'package:edutainment_app/repository/leaderboard_repository.dart';
import 'package:flutter/foundation.dart';

class LeaderBoardProvider with ChangeNotifier {

  List<Leaderboard> _globalLeader = [];
  List<Leaderboard> get globalLeader =>_globalLeader;
  int _your_rank = 0;
  int get your_rank =>_your_rank;

Future<void> getLeadrBoard({email}) async{
  
  // final result =  await LeaderboardRepository().setLeaderboard(correctAnswer: 4, wrongAnswer: 2, quizId: 2);
 final result = await LeaderboardRepository().getLaderbaord();

  result.fold((l){
    print(l);
  }, (r){

    _globalLeader = r.globalLeaderboard;
    print('check leader ${_globalLeader[0].totalCorrect}');
     int index = _globalLeader.indexWhere((leader) => leader.email == email);
    _your_rank = index + 1;
    print(_your_rank);
    print('check leader ${_globalLeader[0].name}');
  });
 notifyListeners();
}



}
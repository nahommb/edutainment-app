import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geez/geez.dart';

import '../../data/game_data.dart';

class GeezToArabicGameScreen extends StatefulWidget {

  static final routeName = 'geez_to_arabic_game_screen';

  @override
  _GeezToArabicGameState createState() => _GeezToArabicGameState();
}

class _GeezToArabicGameState extends State<GeezToArabicGameScreen> {
  final TextEditingController _controller = TextEditingController();
  int _score = 0;
  String _currentGeez = '';
  int _currentArabic = 0;

  final List<Map<String, dynamic>> _numbers = [
    {'geez': '፩', 'arabic': 1},
    {'geez': '፪', 'arabic': 2},
    {'geez': '፫', 'arabic': 3},
    {'geez': '፬', 'arabic': 4},
    {'geez': '፭', 'arabic': 5},
    {'geez': '፮', 'arabic': 6},
    {'geez': '፯', 'arabic': 7},
    {'geez': '፰', 'arabic': 8},
    {'geez': '፱', 'arabic': 9},
    {'geez': '፲', 'arabic': 10},
    {'geez': '፲፩', 'arabic': 11},
    {'geez': '፲፪', 'arabic': 12},
    {'geez': '፲፫', 'arabic': 13},
    {'geez': '፲፬', 'arabic': 14},
    {'geez': '፲፭', 'arabic': 15},
    {'geez': '፳', 'arabic': 20},
    {'geez': '፴', 'arabic': 30},
    {'geez': '፻', 'arabic': 100},
    // Add more if you want
  ];

  @override
  void initState() {
    super.initState();
    _loadNewNumber();
  }

  void _loadNewNumber() {
    final random = Random();
    final gussedNum = random.nextInt(10)+1;
    // gussedNum.toGeez();
    // final item = _numbers[random.nextInt(_numbers.length)];
    _currentGeez = gussedNum.toGeez();
    _currentArabic = gussedNum;
    // _currentGeez = item['geez'];
    // _currentArabic = item['arabic'];
    _controller.clear();
    setState(() {});
  }

  void _checkAnswer() {
    if (int.tryParse(_controller.text) == _currentArabic) {
      _score++;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correct! 🎯',style: TextStyle(color: AppColors.lightBackground),),backgroundColor: AppColors.primary,),
      );
    } else {
      final result = gameData().loadGameData('Geez To Arabic');
      print(result['score']);
      if(result['score'] < _score ||result['score']==null){
        gameData().saveGameData('Geez To Arabic', _score, 1);
      }
      _score=0;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wrong! ❌ The answer was $_currentArabic',style: TextStyle(color: AppColors.lightBackground)),backgroundColor: AppColors.primary,),
      );
    }
    _loadNewNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[50],
      appBar: CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: $_score',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.primary),
              ),
              SizedBox(height: 150,),
              Text(
                'Guess this Ge\'ez number:',
                style: TextStyle(fontSize: 20,color: AppColors.primary),
              ),
              SizedBox(height: 20),
              Text(
                _currentGeez,
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold,color: AppColors.primary),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Arabic number',
                  hintStyle: TextStyle(color: AppColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.primary
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.primary
                    )
                  )
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                child: Text('Submit',style: TextStyle(color: AppColors.lightBackground),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}

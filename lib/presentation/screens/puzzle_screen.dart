import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:flutter/material.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  static final routeName = 'puzzle_screen';
  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.primary,)),) ,
      body: Column(
        children: [
          SizedBox(height: screenHeight*0.35,),
          Container(
            padding: EdgeInsets.only(left: 30,right: 30),
            // color: Colors.black,
            height: 50,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                puzzleSpace(),
                puzzleSpace(),
                puzzleSpace(),
                puzzleSpace(),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Text('Ethiopian Cultural Food',style: TextStyle(fontSize: 20,color: AppColors.primary),)
        ],
      ),
    );
  }
}

Widget puzzleSpace (){

  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(
        color: AppColors.primary,
      )
    ),
    child: TextField(

    ),
  );
}

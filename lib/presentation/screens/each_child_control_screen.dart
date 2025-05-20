import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/leader_board_provider.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EachChildControlScreen extends StatefulWidget {
  final childData ;
  const EachChildControlScreen({super.key,required this.childData});

  @override
  State<EachChildControlScreen> createState() => _EachChildControlScreenState();
}

class _EachChildControlScreenState extends State<EachChildControlScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<LeaderBoardProvider>(context,listen: false).getChildrenRankAndScore(widget.childData.email);
    });
  }
  @override
  Widget build(BuildContext context) {
   final scoreData = Provider.of<LeaderBoardProvider>(context,);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
            Container(
              height: 100,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.primary
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(widget.childData.name,style: TextStyle(color: AppColors.lightBackground,fontSize: 20),),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.childData.email ,style: TextStyle(color: AppColors.lightBackground,fontSize: 12),)
                    ],
                  )
                ],
              ),
            ),
          SizedBox(height: 100,),
          Text('Total Score & Rank',style: TextStyle(fontSize: 15,color: AppColors.primary,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Container(
            height: 200,
            width: 350,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Score',style: TextStyle(fontSize: 24,color: AppColors.lightBackground,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('${scoreData.child_score}',style: TextStyle(fontSize: 20,color: AppColors.lightBackground),)
                  ],
                ),
                Column(
                  children: [
                    Text('Rank',style: TextStyle(fontSize: 24,color: AppColors.lightBackground,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('${scoreData.child_rank}',style: TextStyle(fontSize: 20,color: AppColors.lightBackground),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

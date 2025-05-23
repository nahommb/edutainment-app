import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/spelling_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../data/game_data.dart';

class SpellingPuzzleScreen extends StatefulWidget {
  const SpellingPuzzleScreen({super.key});
  static final routeName = 'spelling_puzzle';

  @override
  State<SpellingPuzzleScreen> createState() => _SpellingPuzzleScreenState();
}

class _SpellingPuzzleScreenState extends State<SpellingPuzzleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpellingProvider>(context, listen: false).fetchQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SpellingProvider spellingProvider = Provider.of<SpellingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.primary,)),
        title: Text('Spelling puzzle',style: TextStyle(color: AppColors.primary,fontSize: 18),),
        actions: [
          spellingProvider.spellingPuzzleModelList.isNotEmpty
              ? Container(
                padding: EdgeInsets.only(right: 5),
                width: 150,
                child: LinearProgressIndicator(
                  color: AppColors.primary,
                  // backgroundColor: AppColors.gray,
                  value:
                      spellingProvider.currentIndex +
                      1 / spellingProvider.spellingPuzzleModelList.length,
                  minHeight: 10,
                ),
              )
              : SizedBox(),
          spellingProvider.spellingPuzzleModelList.isNotEmpty
              ? Text(
                "${spellingProvider.correctAnswer}/${spellingProvider.spellingPuzzleModelList.length}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
              : SizedBox(),
        ],
      ),
      body:
          spellingProvider.spellingPuzzleModelList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.height * 0.2,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: gray.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: blueViolet, width: 1),
                        image: DecorationImage(
                          image: NetworkImage(
                            assetUrl + spellingProvider.currentModel!.image,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    20.height, // Second drop target list
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: spellingProvider.selectedSpelling.length,
                        itemBuilder: (context, index) {
                          return DragTarget<String>(
                            onWillAcceptWithDetails: (data) => true,
                            onAcceptWithDetails: (data) {
                              spellingProvider.addToSelected(
                                index,
                                data.data.toInt(),
                              );
                            },

                            builder: (context, candidateData, rejectedData) {
                              final isHovering = candidateData.isNotEmpty;
                              return Container(
                                width: 60,
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  color:
                                      isHovering
                                          ? AppColors.primary
                                          : AppColors.lightBackground,
                                  // border: Border.all(color: AppColors.primary),
                                ),
                                child: _buildItem(
                                  spellingProvider
                                      .selectedSpelling[index]
                                      .option,
                                  greenColor,
                                  blueColor,
                                  isHovering,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    100.height,
                    GridView.builder(
                      // scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: spellingProvider.currentSpelling.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.8,
                        crossAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
                        // final item = spellingProvider.getSpelling();
                        if (spellingProvider.currentSpelling[index].isVisable) {
                          return Draggable<String>(
                            data: index.toString(),
                            child: _buildItem(
                              spellingProvider.currentSpelling[index].option,
                              greenColor,
                              blueColor,
                              true,
                            ),
                            feedback: Material(
                              color: Colors.transparent,
                              child: _buildItem(
                                spellingProvider.currentSpelling[index].option,
                                greenColor,
                                blueColor,
                                false,
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: _buildItem(
                                spellingProvider.currentSpelling[index].option,
                                greenColor,
                                blueColor,
                                true,
                              ),
                            ),
                          );
                        }
                        return Opacity(
                          opacity: 0.3,
                          child: _buildItem(
                            spellingProvider.currentSpelling[index].option,
                            greenColor,
                            blueColor,
                            true,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      bottomSheet:
          spellingProvider.isSubmitAll
              ? Row(
               mainAxisAlignment: spellingProvider.isSubmited?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.lightBackground
                      ),
                    ),
                  ).onTap(() {
                    if (!spellingProvider.isSubmited) {
                      spellingProvider.setIsSubmited = true;
                    }
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return CheckResultDialog();
                      },
                    );
                  }),
                  if (spellingProvider.isSubmited)
                    Container(
                      height: 30,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        spellingProvider.getCurrentIndex + 1 ==
                                spellingProvider
                                    .spellingPuzzleModelList
                                    .length
                            ? "Finish"
                            : 'Next',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.lightBackground
                        ),
                      ),
                    ).onTap(() {
                      if (spellingProvider.getCurrentIndex + 1 ==
                          spellingProvider.spellingPuzzleModelList.length) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return FinishPuzzleltDialog();
                          },
                        );
                      } else {
                        spellingProvider.setCurrentSpelling();
                      }
                    }),
                ],
              )
              : null,
    );
  }

  Widget _buildItem(
    String label,
    Color greenColor,
    Color blueColor,
    bool isHovering,
  ) {
    return Container(

      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isHovering ? AppColors.primary : AppColors.lightBackground,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.gray),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: isHovering?AppColors.lightBackground:AppColors.primary),
      ),
    );
  }
}

class CheckResultDialog extends StatefulWidget {
  const CheckResultDialog({super.key});

  @override
  State<CheckResultDialog> createState() => _CheckResultDialogState();
}

class _CheckResultDialogState extends State<CheckResultDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    SpellingProvider spellingProvider = Provider.of<SpellingProvider>(context);
    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.cancel, size: 30, color: colorScheme.error).onTap(
              () {
                return Navigator.pop(context);
              },
            ),
          ),
          Icon(
            spellingProvider.checkAnswer()
                ? Icons.check_circle
                : Icons.cancel_outlined,
            size: 38,
            color: spellingProvider.checkAnswer()? AppColors.primary:Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            spellingProvider.checkAnswer() ? 'Awesome job!' : "Wrong answer",
            style: theme.textTheme.headlineSmall?.copyWith(
              color: spellingProvider.checkAnswer()? AppColors.primary:Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        spellingProvider.checkAnswer()
            ? "🎉 Congratulations! you are submit correct answer"
            : "You are submit wrong answer correct answer is ${spellingProvider.currentModel!.answer}",
        style: theme.textTheme.bodyLarge?.copyWith(
          color: AppColors.primary,
          fontSize: 12
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FinishPuzzleltDialog extends StatefulWidget {
  const FinishPuzzleltDialog({super.key});

  @override
  State<FinishPuzzleltDialog> createState() => _FinishPuzzleltDialogState();
}

class _FinishPuzzleltDialogState extends State<FinishPuzzleltDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    SpellingProvider spellingProvider = Provider.of<SpellingProvider>(context);
    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.cancel, size: 30, color: colorScheme.error).onTap(
              () {
                final result = gameData().loadGameData('Spelling Puzzle');

                if(result['score'] < spellingProvider.correctAnswer ||result['score']==null){
                  gameData().saveGameData('Spelling Puzzle', spellingProvider.correctAnswer, 1);
                }else{}
                return Navigator.pop(context);
              },
            ),
          ),
          Icon(Icons.check_circle, size: 48, color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Finished puzzle!',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "🎉 Congratulations! you get ${spellingProvider.correctAnswer}/${spellingProvider.spellingPuzzleModelList.length}",
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              final result = gameData().loadGameData('Spelling Puzzle');

              if(result['score'] < spellingProvider.correctAnswer ||result['score']==null){
                gameData().saveGameData('Spelling Puzzle', spellingProvider.correctAnswer, 1);
              }else{}
              return Navigator.pop(context);
            },
            child: Text('Finish'),
          ),
        ),
      ],
    );
  }
}

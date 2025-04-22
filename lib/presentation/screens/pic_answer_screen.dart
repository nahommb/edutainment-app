import "package:edutainment_app/core/theme/colors_data.dart";
import "package:flutter/material.dart";


class PicAnswerScreen extends StatefulWidget {

  static final routeName = 'pic_answer_screen';

  @override
  State<PicAnswerScreen> createState() => _PicAnswerScreenState();
}

class _PicAnswerScreenState extends State<PicAnswerScreen> {

  int selectedOption = -1;

  final List<String> options = [
    'injera',
    'doro',
    'kitfo',
    'Ayib', // ✅ Correct one
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10),
                child: CircleAvatar(
                  child: Text('1'),
                  backgroundColor: AppColors.lightBackground,
                  foregroundColor: AppColors.primary,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height:screenHeight*0.4,
                      width: double.infinity,
                      child: Image.network('https://picsum.photos/200/300',fit: BoxFit.fill,),
                    ),
                    SizedBox(height: 30),
                    ...List.generate(options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: selectedOption,
                              onChanged: (val) {
                                setState(() {
                                  selectedOption = val!;
                                });
                              },
                              activeColor: AppColors.primary,
                            ),
                            Text(
                              options[index],
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(onPressed: (){}, child: Text('Next',style: TextStyle(color: AppColors.primary),)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

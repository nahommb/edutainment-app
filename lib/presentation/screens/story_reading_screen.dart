import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StoryReadingScreen extends StatefulWidget {

  static final routeName = 'story_reading_screen';
  @override
  _StoryReadingScreen createState() =>
      _StoryReadingScreen();
}

class _StoryReadingScreen
    extends State<StoryReadingScreen> {
  final PageController _controller = PageController();
  final List<Color> colors = [Colors.white, Colors.white, Colors.white,Colors.white,Colors.black];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomAppBar(),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 70),
                padding: EdgeInsets.all(20),
                color: colors[index],
                child: Column(
                  children: [
                    Text('dawiodjpioawd awdoaiwhdioawdio daodhawiodhiowad wdohdioa doaudhoawhduadawdia aiuwdhuiahwudawbdaiuwd aiwuhdad'
                        'dwhduahwdha dpaowjdpoajwda'
                        'daijwdioajdioaidja ad'
                        'adnioajwdiojaiowdioawdoaa a awduiahwdiuadui iauwydiohadhiw'
                        'adwhdiohawoudpawdpoa owudawiodawd'),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: colors.length,
                effect: WormEffect(
                  spacing: 10,
                  radius: 0.0,
                  dotWidth: 25,
                  dotHeight: 5,
                  paintStyle: PaintingStyle.fill,
                  activeDotColor: AppColors.primary,
                  dotColor: Colors.black12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

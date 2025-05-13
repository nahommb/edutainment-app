import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:edutainment_app/models/story_model.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StoryReadingScreen extends StatefulWidget {

  static final routeName = 'story_reading_screen';

  final StoryModel storyModel ;

  StoryReadingScreen({required this.storyModel});

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
     // appBar: CustomAppBar(),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.storyModel.contents.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 70),
                  padding: EdgeInsets.all(20),
                  color: context.isDarkMode?AppColors.darkBackground:AppColors.lightBackground,
                  child: Column(
                    children: [
                      Text(widget.storyModel.contents[index]!.story),
                    ],
                  ),
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
                count: widget.storyModel.contents.length,
                effect: WormEffect(
                  spacing: 10,
                  radius: 0.0,
                  dotWidth: 25,
                  dotHeight: 5,
                  paintStyle: PaintingStyle.fill,
                  activeDotColor: AppColors.primary,
                  dotColor: context.isDarkMode?AppColors.lightBackground:Colors.black12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

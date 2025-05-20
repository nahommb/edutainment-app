import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:edutainment_app/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoryReadingScreen extends StatefulWidget {
  static final routeName = 'story_reading_screen';

  final StoryModel storyModel;

  StoryReadingScreen({required this.storyModel});

  @override
  _StoryReadingScreen createState() => _StoryReadingScreen();
}

class _StoryReadingScreen extends State<StoryReadingScreen> {
  final PageController _controller = PageController();
  FlutterTts flutterTts = FlutterTts();
  bool textToSpeech = false;
  //
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/story_reading_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // PageView Content
          PageView.builder(
            controller: _controller,
            itemCount: widget.storyModel.contents.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: (context.isDarkMode
                        ? AppColors.darkBackground
                        : AppColors.lightBackground)
                        .withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.storyModel.contents[index]!.story,
                        style: TextStyle(fontSize: 12, height: 1.5),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              textToSpeech = !textToSpeech;
                              if (textToSpeech) {
                                speak(widget.storyModel.contents[index]!.story);
                              } else {
                                flutterTts.stop();
                              }
                            });
                          },
                          icon: FaIcon(
                            textToSpeech
                                ? FontAwesomeIcons.volumeXmark
                                : FontAwesomeIcons.volumeHigh,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Page Indicator
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: widget.storyModel.contents.length,
                effect: WormEffect(
                  spacing: 5,
                  radius: 0.0,
                  dotWidth: 15,
                  dotHeight: 5,
                  paintStyle: PaintingStyle.fill,
                  activeDotColor: AppColors.primary,
                  dotColor: context.isDarkMode
                      ? AppColors.lightBackground
                      : Colors.black12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

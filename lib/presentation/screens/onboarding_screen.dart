import 'package:edutainment_app/presentation/screens/init_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/colors_data.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  final List<String> images = [
    'assets/images/onboarding_image1.jpg',
    'assets/images/onboarding_image2.jpg',
    'assets/images/onboarding_image3.jpg',
    'assets/images/onboarding_image4.jpg',
  ];

  final List <Map> titleAndDescription = [
    {'title':'Welcome to Edutainment','description':'Join us on a colorful journey through Ethiopian stories, music, games, and more — all made just for curious little minds!'},
    {'title':'Learn Through Play','description':'Play fun games, solve puzzles, and explore interactive lessons that teach numbers, letters, and values in a way kids love!'},
    {'title':'Explore Ethiopian Culture','description':'Dance to traditional beats, learn local languages, and discover heroes and folktales from across Ethiopia.'},
   // {'title':'Safe & Kid-Friendly','description':'No ads, no worries! Your child can explore, learn, and have fun in a safe and joyful environment.'},
    {'title':' Let’s Get Started!','description':'Tap the button below to start the adventure. It’s time to learn, laugh, and grow together!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),

                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          // Colors.black.withOpacity(0.7),
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  // Text content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          titleAndDescription[index]['title'],
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                       Text(
                          titleAndDescription[index]['description'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                       SizedBox(height: 20),
                        if (index==3)SizedBox(
                             width:180,
                            child: ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setBool('seenOnboard', true);
                                  InitScreen().launch(context,isNewTask: true);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary, // optional: customize button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), // adjust the radius as needed
                                  ),
                                ),
                                child: Text('Start',style: TextStyle(color: Colors.white),))),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Page indicator
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SmoothPageIndicator(
                controller: _controller,
                count: images.length,
                effect: WormEffect(
                  spacing: 10,
                  radius: 5,
                  dotWidth: 10,
                  dotHeight: 10,
                  paintStyle: PaintingStyle.fill,
                  activeDotColor: AppColors.primary,
                  dotColor: context.isDarkMode
                      ? AppColors.lightBackground
                      : Colors.white38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

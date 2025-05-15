import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(controller: _controller, itemBuilder: (context, index) => Column(
            children: [
              Stack(
                children: [
                  Positioned(
                      top:0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset('')
                  ),
                  Positioned(
                      top:0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(''),
                      )
                    ],
                  ))
                ],
              )
            ],
          ),itemCount: 5,),
          Positioned(child: Center(
            child: SmoothPageIndicator(controller: _controller, count: 4),
          ))
        ],
      ),
    );
  }
}

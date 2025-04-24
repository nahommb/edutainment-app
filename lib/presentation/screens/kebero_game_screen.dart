import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class KeberoGame extends StatefulWidget {
  const KeberoGame({super.key});

  static const routeName = '/kebero-game';

  @override
  State<KeberoGame> createState() => _KeberoGameState();
}

class _KeberoGameState extends State<KeberoGame> {
  int score = 0;
  bool isBeatActive = false;
  late Timer beatTimer;

  @override
  void initState() {
    super.initState();
    startBeatLoop();
  }

  void startBeatLoop() {
    beatTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        isBeatActive = true;
      });

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          isBeatActive = false;
        });
      });
    });
  }

  void handleTap() {
    if (isBeatActive) {
      setState(() {
        score++;
      });
    } else {
      setState(() {
        score = score > 0 ? score - 1 : 0;
      });
    }
  }

  @override
  void dispose() {
    beatTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Tap when the Kebero glows!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: handleTap,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: isBeatActive ? Colors.redAccent : Colors.grey[300],
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //   // image: AssetImage('assets/images/kebero.png'),
                  //   fit: BoxFit.cover,
                  // ),
                  boxShadow: isBeatActive
                      ? [BoxShadow(color: Colors.red, blurRadius: 30)]
                      : [],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Score: $score', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

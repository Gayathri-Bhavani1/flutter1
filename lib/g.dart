import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimmer/shimmer.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _slideController;
  late AudioPlayer _audioPlayer;
  bool showCircles = false;

  @override
  void initState() {
    super.initState();
    // Initialize the AudioPlayer
    _audioPlayer = AudioPlayer();
    // Initialize animation controllers
    _rotationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _slideController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    // Load audio and start animations after 3 seconds
    loadAudio();
    _startAnimations();
  }

  // Function to load audio
  loadAudio() async {
    try {
      await _audioPlayer.setAsset('assets/splashmusic.mp3');
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.setSpeed(1);
      await _audioPlayer.load();

      _audioPlayer.play();
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  // Function to start animations
  void _startAnimations() async {
    await Future.delayed(const Duration(seconds: 3));

    _rotationController.forward().then((value) {
      _rotationController.stop();

      _slideController.forward().then((value) {
        setState(() {
          showCircles = true;
        });

        // Navigate to the @Page after the slide animation is complete
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AtPage()),
        );
      });
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _audioPlayer.dispose();
    _rotationController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: const Offset(0, 1.5),
              ).animate(_slideController),
              child: RotationTransition(
                turns:
                    Tween(begin: 0.0, end: -0.25).animate(_rotationController),
                child: Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.grey,
                  direction: ShimmerDirection.rtl,
                  child:
                      Text('@', style: GoogleFonts.robotoFlex(fontSize: 120)),
                ),
              ),
            ),
            if (showCircles)
              Flexible(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        '-Circles',
                        textStyle: GoogleFonts.robotoFlex(fontSize: 120),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 3,
              top: 65,
              child: Shimmer.fromColors(
                baseColor: Colors.blue,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ttb,
                child: Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AtPage extends StatelessWidget {
  const AtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
            Flexible(
            child: RotatedBox(
              quarterTurns: 3,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    '-Circles',
                    textStyle: GoogleFonts.robotoFlex(fontSize: 120),
                    speed: const Duration(milliseconds: 200),
                  ),
                  
                ],
              ),
            ),
          ),
           const RotatedBox(
            quarterTurns: 3,
            child: Text(
              '@',
              style: TextStyle(fontSize: 120, fontFamily: 'robto'),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 3,
            top: 65,
            child: Shimmer.fromColors(
              baseColor: Colors.blue,
              highlightColor: Colors.grey,
              direction: ShimmerDirection.ttb,
              child: Container(
                width: 15.0,
                height: 15.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

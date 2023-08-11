import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimer();
}

class _CountdownTimer extends State<CountdownTimer> {
  // Step 2
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  @override
  void initState() {
    super.initState();
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 5));
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // Step 8
            Text(
              '$minutes:$seconds',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            const SizedBox(height: 20),
            // Step 9
            ElevatedButton(
              onPressed: startTimer,
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 10
            ElevatedButton(
              onPressed: () {
                if (countdownTimer == null || countdownTimer!.isActive) {
                  stopTimer();
                }
              },
              child: const Text(
                'Stop',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 11
            ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

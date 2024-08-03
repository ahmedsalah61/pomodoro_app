import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: timer_App(),
    );
  }
}

class timer_App extends StatefulWidget {
  const timer_App({super.key});

  @override
  State<timer_App> createState() => _date_timeState();
}

class _date_timeState extends State<timer_App> {
  Timer? num;
  Duration duration = const Duration(minutes: 25);

  void startTimer() {
    num = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int sec = duration.inSeconds - 1;
        duration = Duration(seconds: sec);
        if (duration.inSeconds == 0) {
          timer.cancel();
          setState(() {
            duration = const Duration(minutes: 25);
            isrunining = false;
          });
        }
      });
    });
  }

  bool isrunining = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "Pomodoro App",
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black38,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              CircularPercentIndicator(
                radius: 135,
                progressColor: const Color.fromARGB(255, 255, 85, 113),
                backgroundColor: Colors.grey,
                lineWidth: 8.0,
                percent: duration.inMinutes / 25,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,
                center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                  style: const TextStyle(fontSize: 80, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(height: 30),
          isrunining
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                    onPressed: () {
                      num!.cancel();
                      setState(() {
                        duration = const Duration(minutes: 25);
                        isrunining = false;
                      });
                    },
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(14)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: const Text(
                      "cancel",
                      style: TextStyle(fontSize: 27),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (num!.isActive) {
                        setState(() {
                          num!.cancel();
                        });
                      } else {
                        startTimer();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(14)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: Text(
                      (num!.isActive) ? "stop" : "resume",
                      style: const TextStyle(fontSize: 27),
                    ),
                  )
                ])
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    isrunining = true;
                  },
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(14)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: const Text(
                    "Start studying",
                    style: TextStyle(fontSize: 27),
                  ),
                )
        ],
      ),
    );
  }
}

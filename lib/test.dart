import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  Future<void> loadData() async {
    print("Load Data Called");
    Future.delayed(const Duration(seconds: 5)).then(
      (value) {
        print("5 seconds completed");
      },
    );
    print("---------------------1");
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // print("Hello1");
                // await Future.delayed(const Duration(seconds: 2)).then(
                //   (value) {
                //     print("Hello2");
                //   },
                // );

                // print("Hello3");

                loadData();
                print("------Sync-----");
              },
              child: const Text("Start Async Task"),
            ),
            ElevatedButton(
              onPressed: () {
                print("Clicked while waiting!");
              },
              child: const Text("Click Me Anytime"),
            ),
          ],
        ),
      ),
    );
  }
}

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
    await Future.delayed(const Duration(seconds: 15)).then(
      (value) {
        print("$value seconds completed");
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
              onPressed: () {
                // print("Hello1");
                // await Future.delayed(const Duration(seconds: 2)).then(
                //   (value) {
                //     print("Hello2");
                //   },
                // );

                // print("Hello3");

                //  await loadData();
                for (int i = 0; i < 500000000; i++) {
                  double x = i * 3.14159; // heavier operation
                }
                print("Done");
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

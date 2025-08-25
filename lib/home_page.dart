import 'package:counterappblocpackg/bloc_observer.dart';
import 'package:counterappblocpackg/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = CounterCubit(initialState: 69);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:${cubit.state}',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.increment();
                  },
                  child: Container(
                    color: Colors.green,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cubit.decrement();
                  },
                  child: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
            // BlocBuilder<CounterBloc, int>(
            // //    bloc: counterCubit,
            //     builder: (context, counter) {
            //       return Text(
            //         '$counter',
            //         style: Theme.of(context).textTheme.headlineMedium,
            //       );
            //     }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const IncDec(),
          //   ),
          // );
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

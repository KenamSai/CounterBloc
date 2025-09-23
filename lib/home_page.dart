import 'package:counterappblocpackg/bloc/counter_bloc.dart';
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
  Widget build(BuildContext mainContext) {
    // final cubit = CounterCubit(initialState: 69);
    // final bloc = CounterBloc();
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Builder(builder: (ctx) {
        //context cannot found bloc as its create after create,but context is of build which is before that
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(
                            "--main ${mainContext.hashCode} ,----${ctx.hashCode}");
                        // cubit.increment();
                        ctx.read<CounterBloc>().add(IncrementPressed());
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
                        // cubit.decrement();
                        ctx.read<CounterBloc>().add(DecrementPressed());
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
                ),
                // StreamBuilder(
                //   stream: bloc.stream,
                //   initialData: bloc.state,
                //   builder: (context, snapshot) {
                //     if (!snapshot.hasData) {
                //       return const CircularProgressIndicator();
                //     }
                //     return Text(
                //       'You have pushed the button this many times:${snapshot.data}',
                //     );
                //   },
                // ),
                // BlocBuilder<CounterBloc, int>(
                //  // buildWhen: (previous, current) => current % 2 == 0,
                //   builder: (ctx, state) {
                //     return Text(
                //       'You have pushed the button this many times:$state',
                //     );
                //   },
                // ),
                
                BlocListener<CounterBloc, int>(
                  listenWhen: (previous, current) =>
                      previous != current && current % 5 == 0,
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("🎉 Count reached $state"),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: BlocSelector<CounterBloc, int, int?>(
                    selector: (count) => count % 2 == 0 ? count : null,
                    builder: (ctx, count) {
                      if (count == null) {
                        return const CircularProgressIndicator();
                      }
                      return Text(
                        'You have pushed the button this many times:$count',
                      );
                    },
                  ),
                )
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
      }),
    );
  }
}

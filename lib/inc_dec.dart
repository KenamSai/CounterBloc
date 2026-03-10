import 'package:counterappblocpackg/bloc/counter_bloc.dart';
import 'package:counterappblocpackg/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncDec extends StatelessWidget {
  const IncDec({super.key});

  @override
  Widget build(BuildContext context) {
  //  final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              counterBloc.add(
                CounterIncrement(),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
            counterBloc.add(
                CounterDecrement(),
              );
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}

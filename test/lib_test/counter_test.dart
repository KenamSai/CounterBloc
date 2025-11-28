// import 'package:bloc_test/bloc_test.dart';
// import 'package:counterappblocpackg/presentation/bloc/list_bloc/list_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// //Run all tests
// //flutter test

// //Run single file
// //flutter test test/calculator_test.dart

// //Run a specific group/test by name
// //flutter test --plain-name "Addition works"

// //using bloc test
// // 1. as bloc streams are async , cannot emit immediately  after event added
// void main() {
//   late CounterBloc bloc;
//   setUp(
//     () {
//       bloc = CounterBloc();
//     },
//   );
//   tearDown(
//     () {
//       bloc.close();
//     },
//   );
//   group(
//     "Check Counter",
//     () {
//       test(
//         "Initial data",
//         () {
//           expect(bloc.state, isA<CounterInitial>());
//         },
//       );
//       blocTest<CounterBloc, CounterState>(
//         "Increment Counter",
//         build: () => CounterBloc(),
//         act: (bloc) {
//           bloc.add(CounterIncrementPressed());
//         },
//         expect: () => [CounterLoaded(1)],
//       );

//       blocTest<CounterBloc, CounterState>(
//         "On Decrement Counter",
//         build: () => CounterBloc(),
//         seed: () => CounterLoaded(3),
//         act: (bloc) {
//           bloc.add(CounterDecrementPressed());
//         },
//         expect: () => [CounterLoaded(2)],
//       );
//     },
//   );
// }

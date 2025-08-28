## Getting Started


24/08/2025
1.Streams- Sequence of asynchronous data
  async* (async generator)->Stream
  sync*->Iterable

  Stream<int> streamData({required int max}) async* {
    for (int i = 0; i < max; i++) {
      yield i;
    }
  }

  void sumStreamData(Stream<int> streamData) async {
    int sum = 0;
    await for (int val in streamData) {
      sum = sum + val;
    }
    print("Sum is ----$sum");
  }
2.Cubit -Simpler form of bloc(Bloc without events)  
  --emit
  --onChange()->state of cubit changes
  --BlocObserver->
  --addError
3.Bloc-advanced of cubit,which emits new state based on events     [Y bloc is better,how events create impact *LATER*]
  --sealed->A sealed class is a restricted base class.
  --Event Handler->responsible for converting incoming events into outgoing states
  --bloc takes one event, so base class is required
  --onTranistion invoked before onchange

   Advantages of Cubit (Simplicity) and Bloc(Tracebility-easy to know why state state change ocucured, Advanced Event Transformations )
4.Advanced Event Transformations
  -- Debounce = “wait until things calm down before acting”
  -- Throttle = process first event immediately, then ignore rest for duration
5.Bloc Widgets
  a. BlocBuilder
      
         StreamBuilder(
              stream: bloc.stream,
              initialData: bloc.state,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  'You have pushed the button this many times:${snapshot.data}',
                );
              },
            ),
         BlocBuilder<CounterBloc, int>(
                  buildWhen: (previous, current) => current % 2 == 0,
                  builder: (ctx, state) {
                    return Text(
                      'You have pushed the button this many times:$state',
                    );
                  },
                )

      If instance created manually, need to close it , and need to mention in blocbuilder for bloc:.other instance creation is with bloc provider
         final myBloc = CounterBloc();  // manually created instance
      
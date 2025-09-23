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
  --BlocObserver-> first local and then global
  --addError

3.Bloc-advanced of cubit,which emits new state based on events
  --sealed->A sealed class is a restricted base class.
  --Event Handler->responsible for converting incoming events into outgoing states
  --bloc takes one event, so base class is required
  --onTransition invoked before onchange

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
                  bloc:bloc//optional if instance created manually
                )

      If instance created manually, need to close it , and need to mention in BlocBuilder for bloc label ,otherway of  instance creation is with bloc provider
         final myBloc = CounterBloc();  // manually created instance


      To get instance of bloc which is in widget tree, use context.read<Bloc>
      b.BlocSelector
        When A State is of object type with more than one field, any change in one field rebuilds the other fields which is unneesary, but selector solves the problem
         BlocSelector<CounterBloc, int, int>(
                  selector: (state) => state,
                  builder: (ctx, state) {
                    return Text(
                      'You have pushed the button this many times:$state',
                    );
                  },
                )
      c.BlocProvider
      BlocProvider makes the bloc available to all its child widgets, without this its difficult (need to pass bloc through screens)
      final bloc = BlocProvider.of<CounterBloc>(context);
      context.watch<Bloc>() is shorthand for BlocWidgets(Builder, selector) 

      d.MultiBlocProvider is a Flutter widget that merges multiple BlocProvider widgets into one. MultiBlocProvider improves the readability and eliminates the need to nest multiple BlocProviders.

      e.Bloc Listener
         
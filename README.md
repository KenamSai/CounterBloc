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
  --onChange()
  --BlocObserver
  --addError
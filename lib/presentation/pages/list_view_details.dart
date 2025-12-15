import 'package:counterappblocpackg/data/models/list_item_response_model.dart';
import 'package:counterappblocpackg/presentation/bloc/list_bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListViewDetails extends StatefulWidget {
  const ListViewDetails({super.key});

  @override
  State<ListViewDetails> createState() => _ListViewDetailsState();
}

class _ListViewDetailsState extends State<ListViewDetails> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    // print("current----> $currentScroll");
    // print("max----> $maxScroll");

    if (currentScroll >= maxScroll - 200) {
      // ✅ At this point, context is under BlocProvider
      context.read<ListBloc>().add(FetchNextPage());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: BlocListener<ListBloc, ListState>(
            listener: (context, state) {
              if (state is ListDataError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            listenWhen: (previous, current) => current is ListDataError,
            child: BlocBuilder<ListBloc, ListState>(
              builder: (context, state) {
                if (state is ListInitial) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        ListItemResponseModel reason = ListItemResponseModel(
                          body:
                              "xjgxgxghfxhxf vxhfxhfxvhfzf vhfzhfzfzyfz husgusgg sysfyfs fysfyfsyfs fyfysfs fyfsfssf ",
                          id: 0,
                          title: "ugxgxgxgxygx gxgygx hishusgusgsg",
                          userId: 0,
                        );
                        return listItemCard(reason);
                      },
                      itemCount: 2,
                    ),
                  );
                } else if (state is ListDataLoaded) {
                  List<ListItemResponseModel> reasonList = state.list;
                  return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: 60),
                    itemCount: reasonList.length+1,
                    itemBuilder: (context, index) {
                      if (index == reasonList.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        );
                      }
                      ListItemResponseModel reason = reasonList[index];
                      return listItemCard(reason);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget listItemCard(ListItemResponseModel item) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    child: Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID and UserId row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ${item.id ?? '-'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'User: ${item.userId ?? '-'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Title
            Text(
              item.title ?? 'No title',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            // Body
            Text(
              item.body ?? 'No description',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

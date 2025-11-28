import 'package:counterappblocpackg/core/network/base_api_client.dart';
import 'package:counterappblocpackg/data/data_source/list_data_source.dart';
import 'package:counterappblocpackg/data/repository/list_view_repo_impl.dart';
import 'package:counterappblocpackg/domain/entity/reason_entity.dart';
import 'package:counterappblocpackg/domain/repository/list_view_repo.dart';
import 'package:counterappblocpackg/domain/useCases/list_use_case.dart';
import 'package:counterappblocpackg/presentation/bloc/list_bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ListViewRepo>(
      create: (context) => ListViewRepoImpl(
        ListDataSource(
          BaseApiClient(),
        ),
      ),
      child: BlocProvider<ListBloc>(
        create: (context) {
          ListViewRepo repo = context.read<ListViewRepo>();
          return ListBloc(
            ListUseCase(repo),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("ListView"),
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Center(
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
                      return const Text("No Items to display");
                    } else if (state is ListDataLoaded) {
                      List<ReasonEntity> reasonList = state.list;
                      return ListView.builder(
                        itemCount: reasonList.length,
                        itemBuilder: (context, index) {
                          ReasonEntity reason = reasonList[index];
                          return Text(reason.reason);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

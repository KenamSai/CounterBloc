import 'package:counterappblocpackg/core/network/base_api_client.dart';
import 'package:counterappblocpackg/data/data_source/list_data_source.dart';
import 'package:counterappblocpackg/data/repository/list_view_repo_impl.dart';
import 'package:counterappblocpackg/domain/repository/list_view_repo.dart';
import 'package:counterappblocpackg/domain/useCases/list_use_case.dart';
import 'package:counterappblocpackg/presentation/bloc/list_bloc/list_bloc.dart';
import 'package:counterappblocpackg/presentation/pages/list_view_details.dart';
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
        child: const ListViewDetails(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/collection_bloc.dart';

class ProductDataScreen extends StatefulWidget {
  const ProductDataScreen({super.key});

  @override
  State<ProductDataScreen> createState() => _ProductDataScreenState();
}

class _ProductDataScreenState extends State<ProductDataScreen> {
  int pageNo = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CollectionBloc>().add(GetCollectionEvent(page: pageNo));
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<CollectionBloc>().state;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        state is GetCollectionState &&
        !state.isLoadMore) {
      pageNo++;
      context.read<CollectionBloc>().add(GetCollectionEvent(page: pageNo));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Pagination Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          if (state is CollectionInitial || state is CollectionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CollectionError) {
            return Center(child: Text(state.error));
          } else if (state is GetCollectionState) {
            final data = state.resp;
            return ListView.builder(
              controller: _scrollController,
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  if (state.isLoadMore) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (!state.hasMore) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'No More Data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }

                final item = data[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(item.id.toString())),
                    title: Text(item.title ?? '--'),
                    subtitle: Text(item.description ?? '--'),
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

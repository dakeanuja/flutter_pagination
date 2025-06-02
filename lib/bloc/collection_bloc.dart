import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/collection_model.dart';
import '../data/repository/collection_repo.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  int currentPage = 1;
  List<Products> allProducts = [];

  CollectionBloc() : super(CollectionInitial()) {
    on<GetCollectionEvent>((event, emit) async {
      if (event.page == 1) {
        emit(CollectionLoading());
      } else {
        emit(GetCollectionState(resp: allProducts, isLoadMore: true));
      }

      try {
        final collections = await CollectionRepository.fetchProductDetails(
          page: event.page,
        );
        final bool hasMore = collections.isNotEmpty;

        if (event.page == 1) {
          allProducts = collections;
        } else {
          allProducts.addAll(collections);
        }

        currentPage = event.page;
        emit(GetCollectionState(resp: allProducts, hasMore: hasMore));
      } catch (e) {
        emit(CollectionError(error: 'Error while fetching data: $e'));
      }
    });
  }
}

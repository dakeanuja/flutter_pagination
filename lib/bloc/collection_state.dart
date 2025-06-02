part of 'collection_bloc.dart';

@immutable
sealed class CollectionState {}

final class CollectionInitial extends CollectionState {}

final class CollectionLoading extends CollectionState {}

final class CollectionError extends CollectionState {
  final String error;
  CollectionError({required this.error});
}

final class GetCollectionState extends CollectionState {
  final List<Products> resp;
  final bool isLoadMore;
  final bool hasMore;

  GetCollectionState({
    required this.resp,
    this.isLoadMore = false,
    this.hasMore = true,
  });
}

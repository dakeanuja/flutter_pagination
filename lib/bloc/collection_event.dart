part of 'collection_bloc.dart';

@immutable
abstract class CollectionEvent {}

class GetCollectionEvent extends CollectionEvent {
  final int page;
  GetCollectionEvent({required this.page});
}

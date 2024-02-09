part of 'giftmemo_bloc.dart';

sealed class GiftmemoEvent extends Equatable {
  const GiftmemoEvent();

  @override
  List<Object> get props => [];
}

class GetMemoListEvent extends GiftmemoEvent {
  final GiftMemosFilters giftMemosFilters;

  const GetMemoListEvent({required this.giftMemosFilters});
  @override
  // TODO: implement props
  List<Object> get props => [giftMemosFilters];
}

class AddMemoToListEvent extends GiftmemoEvent {
  final GiftMemo giftMemo;

  const AddMemoToListEvent({required this.giftMemo});
  @override
  List<Object> get props => [giftMemo];
}

class UpdateMemoFromListEvent extends GiftmemoEvent {
  final String id;
  final GiftMemo giftMemo;

  const UpdateMemoFromListEvent({required this.id, required this.giftMemo});
  @override
  List<Object> get props => [id, giftMemo];
}

class DeleteMemoFromListEvent extends GiftmemoEvent {
  final GiftMemo giftMemo;

  const DeleteMemoFromListEvent({required this.giftMemo});
  @override
  List<Object> get props => [giftMemo];
}

part of 'giftmemo_bloc.dart';

sealed class GiftMemoState extends Equatable {
  const GiftMemoState();

  @override
  List<Object> get props => [];
}

final class EmptyState extends GiftMemoState {}

final class LoadingState extends GiftMemoState {}

final class VoidLoadedState extends GiftMemoState {}

final class GetLoadedState extends GiftMemoState {
  final List<GiftMemo> memos;

  const GetLoadedState({required this.memos});
  @override
  List<Object> get props => [memos];
}

final class ErrorState extends GiftMemoState {
  final String message;

  const ErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

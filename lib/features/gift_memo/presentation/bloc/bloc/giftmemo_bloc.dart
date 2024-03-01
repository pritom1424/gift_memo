import 'package:gift_memo/core/generics/constants.dart';

import 'blocs.dart';
part 'giftmemo_event.dart';
part 'giftmemo_state.dart';

class GiftMemoBloc extends Bloc<GiftmemoEvent, GiftMemoState> {
  final AddGiftMemo addGiftMemo;
  final GetGiftMemos getGiftMemos;
  final DeleteGiftMemo deleteGiftMemo;
  final UpdateGiftMemo updateGiftMemo;
  GiftMemoBloc(
      {required this.addGiftMemo,
      required this.getGiftMemos,
      required this.deleteGiftMemo,
      required this.updateGiftMemo})
      : super(EmptyState()) {
    on<AddMemoToListEvent>((event, emit) async {
      final failOrvoid =
          await addGiftMemo(AddGiftParams(giftMemo: event.giftMemo));
      emit(_eitherLoadedORErrorState(failOrvoid));
    });

    on<UpdateMemoFromListEvent>((event, emit) async {
      final failOrvoid = await updateGiftMemo(
          UpdateGiftParams(id: event.id, giftMemo: event.giftMemo));
      emit(_eitherLoadedORErrorState(failOrvoid));
    });

    on<DeleteMemoFromListEvent>((event, emit) async {
      final failorvoid =
          await deleteGiftMemo(DeleteGiftParams(giftMemo: event.giftMemo));

      emit(_eitherLoadedORErrorState(failorvoid));
    });

    on<GetMemoListEvent>((event, emit) async {
      emit(LoadingState());
      final failOrMemos = await getGiftMemos(
          GetGiftParams(giftMemosFilters: event.giftMemosFilters));

      emit(_eitherLoadedORErrorStateNotVoid(failOrMemos));
    });
  }
  GiftMemoState _eitherLoadedORErrorState(
      Either<Failures, void> failureOrvoid) {
    return failureOrvoid.fold(
        (failure) => ErrorState(message: _mapFailureToMessage(failure)),
        (r) => VoidLoadedState());
  }

  GiftMemoState _eitherLoadedORErrorStateNotVoid(
      Either<Failures, List<GiftMemo>> failureOrvoid) {
    return failureOrvoid.fold(
        (failure) => ErrorState(message: _mapFailureToMessage(failure)),
        (memos) => GetLoadedState(memos: memos));
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return Constants.SERVER_FAILURE_MESSAGE;
      case InterNetConnectionFailure _:
        return Constants.INTERNET_FAILURE_MESSAGE;
      default:
        return Constants.DEFAULT_FAILURE_MESSAGE;
    }
  }
}

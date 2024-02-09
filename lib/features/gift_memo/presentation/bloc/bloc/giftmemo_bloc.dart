import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/core/errors/failures.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/add_gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/delete_gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/get_gift_memos.dart';
import 'package:gift_memo/features/gift_memo/domain/usecases/update_gift_memo.dart';

part 'giftmemo_event.dart';
part 'giftmemo_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server failed";
const String INTERNET_FAILURE_MESSAGE = "Internet connection failed";
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The number must be non negative";

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
      emit(LoadingState());
      final failOrvoid =
          await addGiftMemo(AddGiftParams(giftMemo: event.giftMemo));
      emit(_eitherLoadedORErrorState(failOrvoid));
    });

    on<UpdateMemoFromListEvent>((event, emit) async {
      emit(LoadingState());
      final failOrvoid = await updateGiftMemo(
          UpdateGiftParams(id: event.id, giftMemo: event.giftMemo));
      emit(_eitherLoadedORErrorState(failOrvoid));
    });

    on<DeleteMemoFromListEvent>((event, emit) async {
      emit(LoadingState());
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
        return SERVER_FAILURE_MESSAGE;
      case InterNetConnectionFailure _:
        return INTERNET_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

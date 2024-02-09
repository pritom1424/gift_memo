import 'package:dartz/dartz.dart';
import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/core/errors/failures.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';

abstract class GiftMemoRepos {
  Future<Either<Failures, List<GiftMemo>>> getGiftMemos(
      GiftMemosFilters giftMemosFilters);

  Future<Either<Failures, void>> addGiftMemo(GiftMemo newgiftMemo);

  Future<Either<Failures, void>> updateGiftMemo(
      String id, GiftMemo updatedGiftMemo);

  Future<Either<Failures, void>> deleteGiftMemo(GiftMemo deletedMemo);
}

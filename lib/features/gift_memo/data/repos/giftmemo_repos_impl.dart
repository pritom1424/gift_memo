import 'package:dartz/dartz.dart';
import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/core/errors/exceptions.dart';
import 'package:gift_memo/core/errors/failures.dart';
import 'package:gift_memo/core/networks/network_info.dart';
import 'package:gift_memo/features/gift_memo/data/datasources/giftmemo_remotedata_source.dart';
import 'package:gift_memo/features/gift_memo/data/models/giftmemo_model.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/repos/giftmemo_repos.dart';

class GiftMemoReposImpl extends GiftMemoRepos {
  final NetworkInfo networkInfo;
  final GiftMemoRemoteDataSource giftMemoRemoteDataSource;

  GiftMemoReposImpl(
      {required this.networkInfo, required this.giftMemoRemoteDataSource});

  //main implementation

  @override
  Future<Either<Failures, void>> addGiftMemo(GiftMemo newgiftMemo) async {
    return await voidMemoModify(
      newgiftMemo,
      () => giftMemoRemoteDataSource.addGiftMemoDB(
        GiftMemoModel.fromGiftMemo(newgiftMemo),
      ),
    );
  }

  @override
  Future<Either<Failures, void>> deleteGiftMemo(GiftMemo deletedMemo) async {
    return await voidMemoModify(
        deletedMemo,
        () => giftMemoRemoteDataSource.deleteGiftMemoDB(
              GiftMemoModel.fromGiftMemo(deletedMemo),
            ));
  }

  @override
  Future<Either<Failures, List<GiftMemo>>> getGiftMemos(
      GiftMemosFilters giftMemosFilters) async {
    final listTemp = await listMemoModify(
        () => giftMemoRemoteDataSource.getGiftMemosDB(giftMemosFilters));

    return listTemp;
  }

  @override
  Future<Either<Failures, void>> updateGiftMemo(
      String id, GiftMemo updatedGiftMemo) async {
    return await voidMemoModify(
      updatedGiftMemo,
      () => giftMemoRemoteDataSource.updateGiftMemoDB(
        id,
        GiftMemoModel.fromGiftMemo(updatedGiftMemo),
      ),
    );
  }
// end main implementations

//partial methods
  Future<Either<Failures, void>> voidMemoModify(
      GiftMemo newgiftMemo, Future<void> Function() func) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedGift = await func();
        return Right(modifiedGift);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(InterNetConnectionFailure());
  }

  Future<Either<Failures, List<GiftMemo>>> listMemoModify(
      Future<List<GiftMemo>> Function() func) async {
    if (await networkInfo.isConnected) {
      try {
        final modifiedGift = await func();
        return Right(modifiedGift);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(InterNetConnectionFailure());
  }
}

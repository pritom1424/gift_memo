import 'package:dartz/dartz.dart';
import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/core/errors/failures.dart';
import 'package:gift_memo/core/usecases/usecase.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/repos/giftmemo_repos.dart';

class GetGiftMemos implements Usecase<List<GiftMemo>, WithParams> {
  final GiftMemoRepos repos;

  GetGiftMemos({required this.repos});

  @override
  Future<Either<Failures, List<GiftMemo>>> call(WithParams params) async {
    return await repos.getGiftMemos(params.props[0] as GiftMemosFilters);
  }
}

class GetGiftParams extends WithParams {
  final GiftMemosFilters giftMemosFilters;

  const GetGiftParams({required this.giftMemosFilters});

  @override
  // TODO: implement props
  List<Object?> get props => [giftMemosFilters];
}

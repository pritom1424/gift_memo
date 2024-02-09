import 'package:dartz/dartz.dart';
import 'package:gift_memo/core/errors/failures.dart';
import 'package:gift_memo/core/usecases/usecase.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/repos/giftmemo_repos.dart';

class UpdateGiftMemo implements Usecase<void, WithParams> {
  final GiftMemoRepos repos;

  UpdateGiftMemo({required this.repos});
  @override
  Future<Either<Failures, void>> call(WithParams params) async {
    return await repos.updateGiftMemo(
        params.props[0] as String, params.props[1] as GiftMemo);
  }
}

class UpdateGiftParams extends WithParams {
  final String id;
  final GiftMemo giftMemo;

  UpdateGiftParams({required this.id, required this.giftMemo});
  @override
  // TODO: implement props
  List<Object?> get props => [id, giftMemo];
}

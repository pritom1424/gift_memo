import 'package:dartz/dartz.dart';
import 'package:gift_memo/core/errors/failures.dart';
import 'package:gift_memo/core/usecases/usecase.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/repos/giftmemo_repos.dart';

class DeleteGiftMemo implements Usecase<void, WithParams> {
  final GiftMemoRepos repos;

  DeleteGiftMemo({required this.repos});
  @override
  Future<Either<Failures, void>> call(WithParams params) async {
    return await repos.deleteGiftMemo(params.props[0] as GiftMemo);
  }
}

class DeleteGiftParams extends WithParams {
  final GiftMemo giftMemo;

  const DeleteGiftParams({required this.giftMemo});

  @override
  // TODO: implement props
  List<Object?> get props => [giftMemo];
}

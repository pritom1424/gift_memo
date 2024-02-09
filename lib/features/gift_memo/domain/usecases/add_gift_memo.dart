import 'package:dartz/dartz.dart';
import 'package:gift_memo/core/errors/failures.dart';
import 'package:gift_memo/core/usecases/usecase.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/domain/repos/giftmemo_repos.dart';

class AddGiftMemo implements Usecase<void, WithParams> {
  final GiftMemoRepos repos;

  AddGiftMemo({required this.repos});
  @override
  Future<Either<Failures, void>> call(WithParams params) async {
    return await repos.addGiftMemo(params.props[0] as GiftMemo);
  }
}

class AddGiftParams extends WithParams {
  final GiftMemo giftMemo;

  const AddGiftParams({required this.giftMemo});

  @override
  // TODO: implement props
  List<Object?> get props => [giftMemo];
}

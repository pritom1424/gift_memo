import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_memo/core/errors/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class WithParams extends Equatable {
  const WithParams();

  //List<dynamic> get params;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

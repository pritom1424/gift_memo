import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failures {}

class InterNetConnectionFailure extends Failures {}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  NetworkFailure({required this.code, this.message});

  final int code;
  final String? message;

  @override
  List<Object?> get props => [code, message];
}

class ParsingFailure extends Failure {
  ParsingFailure({this.message});
  final String? message;

  @override
  List<Object?> get props => [message];
}

class DetailFailure extends Failure {
  DetailFailure({this.message});
  final String? message;

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {}

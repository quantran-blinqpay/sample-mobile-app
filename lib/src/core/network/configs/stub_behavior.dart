import 'package:equatable/equatable.dart';

class StubBehavior extends Equatable {
  StubBehavior({this.delay, this.data});
  final dynamic data;
  Duration? delay;

  StubBehavior delayed(Duration duration) {
    delay = duration;
    return this;
  }

  StubBehavior? get never {
    return null;
  }

  @override
  List<Object?> get props => [data, delay];
}

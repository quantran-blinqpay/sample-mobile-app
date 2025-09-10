import 'package:qwid/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recombee_session.g.dart';

@JsonSerializable()
class RecombeeSession {

  RecombeeSession({
    this.success,
    this.sessionId,
  });

  @JsonKey()
  final bool? success;
  @JsonKey(name: 'session_id')
  final String? sessionId;

  factory RecombeeSession.fromJson(Map<String, dynamic> json) => _$RecombeeSessionFromJson(json);

  Map<String, dynamic> toJson() => _$RecombeeSessionToJson(this);

}
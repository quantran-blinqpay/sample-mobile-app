import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'session_dto.dart';

part 'movie_session_dto.g.dart';

@JsonSerializable()
class MovieSessionDto extends Equatable {
  @JsonKey(name: 'cinema_id')
  final String? cinemaId;
  @JsonKey(name: 'sessions')
  final List<SessionDto>? sessions;

  const MovieSessionDto({this.cinemaId, this.sessions});

  factory MovieSessionDto.fromJson(Map<String, dynamic> json) {
    return _$MovieSessionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MovieSessionDtoToJson(this);

  MovieSessionDto copyWith({
    String? cinemaId,
    List<SessionDto>? sessions,
  }) {
    return MovieSessionDto(
      cinemaId: cinemaId ?? this.cinemaId,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [cinemaId, sessions];
}

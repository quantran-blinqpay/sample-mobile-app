import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? cinema;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String? movie;
  final String? type;
  @JsonKey(name: 'price_pattern')
  final String? pricePattern;
  final String? room;
  @JsonKey(name: 'start_time')
  final DateTime? startTime;
  @JsonKey(name: 'end_time')
  final DateTime? endTime;
  @JsonKey(name: '__v')
  final int? v;

  const SessionDto({
    this.id,
    this.cinema,
    this.updatedAt,
    this.createdAt,
    this.movie,
    this.type,
    this.pricePattern,
    this.room,
    this.startTime,
    this.endTime,
    this.v,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) {
    return _$SessionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);

  SessionDto copyWith({
    String? id,
    String? cinema,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? movie,
    String? type,
    String? pricePattern,
    String? room,
    DateTime? startTime,
    DateTime? endTime,
    int? v,
  }) {
    return SessionDto(
      id: id ?? this.id,
      cinema: cinema ?? this.cinema,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      movie: movie ?? this.movie,
      type: type ?? this.type,
      pricePattern: pricePattern ?? this.pricePattern,
      room: room ?? this.room,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      v: v ?? this.v,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      cinema,
      updatedAt,
      createdAt,
      movie,
      type,
      pricePattern,
      room,
      startTime,
      endTime,
      v,
    ];
  }
}

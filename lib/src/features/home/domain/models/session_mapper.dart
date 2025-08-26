import 'package:designerwardrobe/src/features/home/data/remote/dtos/session_dto.dart';
import 'session.dart';

extension SessionData on SessionDto {
  SessionModel toModel() => SessionModel(
      id: id,
      cinema: cinema,
      createdAt: createdAt,
      endTime: endTime,
      movie: movie,
      pricePattern: pricePattern,
      room: room,
      startTime: startTime,
      type: type,
      updatedAt: updatedAt,
      v: v);
}
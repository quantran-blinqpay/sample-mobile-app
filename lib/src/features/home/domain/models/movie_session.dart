import 'package:qwid/src/features/home/domain/models/session.dart';

class MovieSessionModel {
  final String? cinemaId;
  final List<SessionModel>? sessions;

  MovieSessionModel({required this.cinemaId, required this.sessions});
}

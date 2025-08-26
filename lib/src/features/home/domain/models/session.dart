
class SessionModel {
  final String? id;
  final String? cinema;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String? movie;
  final String? type;
  final String? pricePattern;
  final String? room;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? v;

  SessionModel(
      {this.id,
      this.cinema,
      this.updatedAt,
      this.createdAt,
      this.movie,
      this.type,
      this.pricePattern,
      this.room,
      this.startTime,
      this.endTime,
      this.v});
}

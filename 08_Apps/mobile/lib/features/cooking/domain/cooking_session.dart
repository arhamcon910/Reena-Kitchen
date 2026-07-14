enum CookingStatus { idle, cooking, paused, done }

class CookingSession {
  const CookingSession({
    required this.recipeId,
    required this.recipeName,
    required this.totalSeconds,
    this.elapsed = 0,
    this.status = CookingStatus.idle,
    this.rating = 0,
  });

  final String recipeId;
  final String recipeName;
  final int totalSeconds;
  final int elapsed;
  final CookingStatus status;
  final int rating;

  int get remaining => (totalSeconds - elapsed).clamp(0, totalSeconds);
  double get progress =>
      totalSeconds > 0 ? elapsed / totalSeconds : 0.0;
  bool get isFinished => remaining == 0;

  String get remainingFormatted {
    final m = remaining ~/ 60;
    final s = remaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  CookingSession copyWith({
    int? elapsed,
    CookingStatus? status,
    int? rating,
  }) =>
      CookingSession(
        recipeId: recipeId,
        recipeName: recipeName,
        totalSeconds: totalSeconds,
        elapsed: elapsed ?? this.elapsed,
        status: status ?? this.status,
        rating: rating ?? this.rating,
      );
}

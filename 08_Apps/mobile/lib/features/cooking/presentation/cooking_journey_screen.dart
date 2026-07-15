import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/storage/auth_storage.dart';
import '../../recipe/data/recipe_repository.dart';
import '../../recipe/domain/recipe.dart';
import '../domain/cooking_session.dart';

class CookingJourneyScreen extends ConsumerStatefulWidget {
  const CookingJourneyScreen({super.key, required this.recipeId});
  final String recipeId;

  @override
  ConsumerState<CookingJourneyScreen> createState() =>
      _CookingJourneyScreenState();
}

class _CookingJourneyScreenState
    extends ConsumerState<CookingJourneyScreen> {
  Recipe? _recipe;
  CookingSession? _session;
  Timer? _timer;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipe();
  }

  Future<void> _loadRecipe() async {
    try {
      final recipe = await ref
          .read(recipeRepositoryProvider)
          .getById(widget.recipeId);
      setState(() {
        _recipe = recipe;
        _session = CookingSession(
          recipeId: recipe.id,
          recipeName: recipe.name,
          totalSeconds: recipe.cookMinutes * 60,
        );
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  void _start() {
    setState(() =>
        _session = _session!.copyWith(status: CookingStatus.cooking));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_session?.status != CookingStatus.cooking) return;
      final newElapsed = (_session!.elapsed + 1);
      if (newElapsed >= _session!.totalSeconds) {
        _timer?.cancel();
        setState(() => _session = _session!.copyWith(
            elapsed: _session!.totalSeconds,
            status: CookingStatus.done));
      } else {
        setState(() =>
            _session = _session!.copyWith(elapsed: newElapsed));
      }
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() =>
        _session = _session!.copyWith(status: CookingStatus.paused));
  }

  void _resume() => _start();

  void _markDone() {
    _timer?.cancel();
    setState(() => _session =
        _session!.copyWith(status: CookingStatus.done));
  }

  Future<void> _saveAndExit(int rating) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final history = prefs.getStringList('reena.meal_history.v1') ?? [];
    history.add('${widget.recipeId}:$rating:${DateTime.now().toIso8601String()}');
    if (history.length > 50) history.removeAt(0);
    await prefs.setStringList('reena.meal_history.v1', history);
    if (mounted) context.pop();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }
    if (_recipe == null || _session == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Recipe not found')),
      );
    }

    final isDone = _session!.status == CookingStatus.done;

    return Scaffold(
      appBar: AppBar(
        title: Text(_recipe!.name),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: isDone ? _RatingView(onRate: _saveAndExit) : _CookingView(
            session: _session!,
            onStart: _start,
            onPause: _pause,
            onResume: _resume,
            onDone: _markDone,
          ),
        ),
      ),
    );
  }
}

class _CookingView extends StatelessWidget {
  const _CookingView({
    required this.session,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onDone,
  });
  final CookingSession session;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final isCooking = session.status == CookingStatus.cooking;
    final isPaused = session.status == CookingStatus.paused;
    final isIdle = session.status == CookingStatus.idle;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Progress circle ────────────────────────────────────────────
        SizedBox(
          width: 240,
          height: 240,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: session.progress,
                  strokeWidth: 12,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    session.remainingFormatted,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFeatures: const [
                              FontFeature.tabularFigures()
                            ]),
                  ),
                  Text('remaining',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),

        // ── Controls ───────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIdle)
              FilledButton.icon(
                onPressed: onStart,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Cooking'),
                style: FilledButton.styleFrom(
                    minimumSize: const Size(180, 52)),
              ),
            if (isCooking) ...[
              OutlinedButton.icon(
                onPressed: onPause,
                icon: const Icon(Icons.pause),
                label: const Text('Pause'),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: onDone,
                icon: const Icon(Icons.check),
                label: const Text('Done!'),
              ),
            ],
            if (isPaused) ...[
              FilledButton.icon(
                onPressed: onResume,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Resume'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onDone,
                icon: const Icon(Icons.check),
                label: const Text('Done'),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: onDone,
          child: const Text('Skip timer — mark as done'),
        ),
      ],
    );
  }
}

class _RatingView extends StatefulWidget {
  const _RatingView({required this.onRate});
  final Future<void> Function(int rating) onRate;
  @override
  State<_RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<_RatingView> {
  int _rating = 0;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, size: 80, color: Color(0xFF4CAF50)),
        const SizedBox(height: 24),
        Text('Cooking complete! 🎉',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('How did it turn out?',
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 32),

        // ── Star rating ───────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) {
            final star = i + 1;
            return GestureDetector(
              onTap: () => setState(() => _rating = star),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  _rating >= star ? Icons.star : Icons.star_border,
                  size: 48,
                  color: _rating >= star
                      ? const Color(0xFFFFC107)
                      : Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          _rating == 0
              ? 'Tap to rate'
              : ['', 'Needs work', 'Okay', 'Good', 'Great!', 'Amazing! ⭐'][_rating],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 40),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            onPressed: _saving
                ? null
                : () async {
                    setState(() => _saving = true);
                    await widget.onRate(_rating);
                  },
            child: _saving
                ? const CircularProgressIndicator()
                : Text(_rating == 0 ? 'Skip' : 'Save & Exit'),
          ),
        ),
      ],
    );
  }
}

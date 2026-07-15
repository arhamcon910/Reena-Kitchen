import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode  = ref.watch(themeModeProvider);
    final notifs     = ref.watch(notificationProvider);
    final healthGoals = ref.watch(healthGoalsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Settings'),
            centerTitle: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Appearance ────────────────────────────────────────────
                const _Section('Appearance'),
                Card(
                  child: Column(children: [
                    ListTile(
                      leading: const Icon(Icons.brightness_6_outlined),
                      title: const Text('Theme'),
                      subtitle: Text(_themeName(themeMode)),
                      trailing: SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment(value: ThemeMode.light,
                              icon: Icon(Icons.light_mode, size: 16)),
                          ButtonSegment(value: ThemeMode.system,
                              icon: Icon(Icons.brightness_auto, size: 16)),
                          ButtonSegment(value: ThemeMode.dark,
                              icon: Icon(Icons.dark_mode, size: 16)),
                        ],
                        selected: {themeMode},
                        onSelectionChanged: (v) =>
                            ref.read(themeModeProvider.notifier).set(v.first),
                        style: const ButtonStyle(
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),

                // ── Notifications ────────────────────────────────────────
                const _Section('Notifications'),
                Card(
                  child: Column(children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.restaurant_outlined),
                      title: const Text('Meal reminders'),
                      subtitle: const Text('Daily meal plan notifications'),
                      value: notifs.mealReminder,
                      onChanged: (v) =>
                          ref.read(notificationProvider.notifier).setMealReminder(v),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.shopping_cart_outlined),
                      title: const Text('Shopping reminders'),
                      subtitle: const Text('Notify when pantry items are low'),
                      value: notifs.shopReminder,
                      onChanged: (v) =>
                          ref.read(notificationProvider.notifier).setShopReminder(v),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),

                // ── Health Goals ─────────────────────────────────────────
                const _Section('Health Goals'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select your family\'s health goals',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.6),
                                )),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: availableHealthGoals.map((goal) {
                            final selected = healthGoals.contains(goal);
                            return FilterChip(
                              label: Text(goal),
                              selected: selected,
                              onSelected: (_) => ref
                                  .read(healthGoalsProvider.notifier)
                                  .toggle(goal),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ── About ─────────────────────────────────────────────────
                const _Section('About'),
                const Card(
                  child: Column(children: [
                    ListTile(
                      leading: Icon(Icons.kitchen),
                      title: Text('REENA AI Kitchen'),
                      subtitle: Text('Version ${AppConstants.version}'),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.eco_outlined),
                      title: Text('Vegetarian policy'),
                      subtitle: Text('All recommendations are 100% vegetarian'),
                      trailing: Icon(Icons.check_circle,
                          color: Color(0xFF4CAF50)),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.lock_outlined),
                      title: Text('Privacy'),
                      subtitle: Text(
                          'Your data stays on your device. No tracking.'),
                    ),
                  ]),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _themeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:  return 'Light';
      case ThemeMode.dark:   return 'Dark';
      case ThemeMode.system: return 'System default';
    }
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../household/data/household_repository.dart';
import '../../../household/providers/household_provider.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final householdAsync = ref.watch(householdDetailsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Profile'),
            centerTitle: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Avatar ─────────────────────────────────────────────
                Center(
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      (auth.name?.isNotEmpty == true
                              ? auth.name![0]
                              : auth.email?[0] ?? 'R')
                          .toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(auth.name ?? 'REENA User',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
                Center(
                  child: Text(auth.email ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          )),
                ),
                const SizedBox(height: 28),

                // ── Household ─────────────────────────────────────────
                Text('Household',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 8),
                householdAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const ListTile(
                      title: Text('Could not load household')),
                  data: (household) {
                    if (household == null) {
                      return const ListTile(title: Text('No household yet'));
                    }
                    final members =
                        household['members'] as List<dynamic>? ?? [];
                    return Card(
                      child: Column(children: [
                        ListTile(
                          leading: const Icon(Icons.home_outlined),
                          title: Text(household['name'] as String? ?? ''),
                          subtitle:
                              Text('${members.length} member(s)'),
                        ),
                        const Divider(height: 1),
                        ...members.map((m) {
                          final member = m as Map<String, dynamic>;
                          return ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 16,
                              child: Text(
                                (member['name'] as String? ?? '?')[0]
                                    .toUpperCase(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            title: Text(member['name'] as String? ?? ''),
                            subtitle: Text(member['role'] as String? ?? ''),
                          );
                        }),
                        ListTile(
                          leading: Icon(Icons.add,
                              color: Theme.of(context).colorScheme.primary),
                          title: Text('Add member',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary)),
                          onTap: () => _addMember(context, ref,
                              household['id'] as String),
                        ),
                      ]),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // ── Settings ──────────────────────────────────────────
                Text('App',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 8),
                Card(
                  child: Column(children: [
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('Version'),
                      trailing: Text(AppConstants.version,
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.logout,
                          color: Theme.of(context).colorScheme.error),
                      title: Text('Sign Out',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error)),
                      onTap: () async {
                        await ref.read(authProvider.notifier).logout();
                        if (context.mounted) {
                          context.go(AppConstants.routeLogin);
                        }
                      },
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

  Future<void> _addMember(
      BuildContext context, WidgetRef ref, String householdId) async {
    final nameCtrl = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Member'),
        content: TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(
              labelText: 'Name', border: OutlineInputBorder()),
          textCapitalization: TextCapitalization.words,
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, nameCtrl.text.trim()),
              child: const Text('Add')),
        ],
      ),
    );

    if (result == null || result.isEmpty) return;
    try {
      await ref.read(householdRepositoryProvider).addMember(
            householdId: householdId,
            name: result,
          );
     ref.invalidate(householdDetailsProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')));
      }
    }
  }
}

final householdDetailsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
  final householdId = await ref.watch(householdIdProvider.future);
  if (householdId.isEmpty) return null;
  return ref.read(householdRepositoryProvider).findById(householdId);
});
# Node / NestJS
node_modules/
dist/
.env
*.db
*.db-journal
create-db.mjs
check-db.mjs

# Flutter
pubspec.lock
.dart_tool/
build/
*.g.dart
*.freezed.dart
analyze.txt
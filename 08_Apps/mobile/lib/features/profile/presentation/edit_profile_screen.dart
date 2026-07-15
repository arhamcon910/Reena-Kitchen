import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/auth_storage.dart';
import '../../auth/providers/auth_provider.dart';
import '../../household/data/household_repository.dart';
import '../../household/providers/household_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _nameCtrl      = TextEditingController();
  final _householdCtrl = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final auth = ref.read(authProvider);
    _nameCtrl.text = auth.name ?? '';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _householdCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final storage = ref.read(authStorageProvider);
      final newName = _nameCtrl.text.trim();
      if (newName.isNotEmpty) {
        await storage.saveUser(
          email: ref.read(authProvider).email ?? '',
          name: newName,
        );
        // Refresh auth state by re-reading storage
        ref.read(authProvider.notifier)
          // ignore: invalid_use_of_protected_member
          ..state = ref.read(authProvider).isAuthenticated
              ? ref.read(authProvider)
              : ref.read(authProvider);
      }

      // Update household name if provided
      final householdName = _householdCtrl.text.trim();
      if (householdName.isNotEmpty) {
        final householdId = await ref.read(householdIdProvider.future);
        if (householdId.isNotEmpty) {
          await ref
              .read(householdRepositoryProvider)
              .updateName(householdId, householdName);
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated'),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ── Avatar ─────────────────────────────────────────────────────
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    (auth.name?.isNotEmpty == true
                            ? auth.name![0]
                            : 'R')
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ── Name ───────────────────────────────────────────────────────
          Text('Personal', style: Theme.of(context).textTheme.titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.primary,
                         fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Display name',
              prefixIcon: Icon(Icons.person_outlined),
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              border: const OutlineInputBorder(),
              hintText: auth.email ?? '',
            ),
          ),
          const SizedBox(height: 24),

          // ── Household ──────────────────────────────────────────────────
          Text('Household', style: Theme.of(context).textTheme.titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.primary,
                         fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _householdCtrl,
            decoration: const InputDecoration(
              labelText: 'Household name (optional)',
              prefixIcon: Icon(Icons.home_outlined),
              border: OutlineInputBorder(),
              hintText: 'e.g. The Arham Family',
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: _saving ? null : _save,
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}

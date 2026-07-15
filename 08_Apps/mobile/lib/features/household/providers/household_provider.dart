import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/auth_storage.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/household_repository.dart';

final householdIdProvider = FutureProvider<String>((ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isAuthenticated) return '';

  final storage = ref.read(authStorageProvider);
  final existing = storage.prefs.getString('reena.household.id.v1');
  if (existing != null && existing.isNotEmpty) return existing;

  final repo = ref.read(householdRepositoryProvider);
  final name = authState.name ?? 'My Household';
  final household = await repo.create(name: "$name's Kitchen");
  final id = household['id'] as String;
  await storage.prefs.setString('reena.household.id.v1', id);
  return id;
});

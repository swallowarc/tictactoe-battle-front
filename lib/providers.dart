import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe_battle/tictactoe_battle.dart';

import 'domains/login_status.dart';
import 'infrastructures/env/env.dart';
import 'infrastructures/local_storage/local_storage.dart';
import 'repositories/local_storage_repository.dart';
import 'repositories/tictactoe_battle_backend_repository.dart';
import 'services/battle_service.dart';
import 'services/login_service.dart';

/// Env
final Provider<Env> _envProvider = Provider((ref) => Env());

/// LocalStorage
final Provider<LocalStorage> localStorageProvider = Provider((ref) => LocalStorage());

/// LocalStorageRepository
final Provider<LocalStorageRepository> localStorageRepositoryProvider =
    Provider((ref) => LocalStorageRepository(ref.read(localStorageProvider)));

/// TicTacToeBattleBackendRepository
final Provider<TicTacToeBattleBackendRepository> ticTacToeBattleBackendRepositoryProvider = Provider(
  (ref) {
    final repo = TicTacToeBattleBackendRepository(ref.read(_envProvider).backendURI);
    ref.onDispose(() => repo.shutdown());
    return repo;
  },
);

/// LoginService
final StateNotifierProvider<LoginService, LoginStatus> loginServiceProvider = StateNotifierProvider(
  (ref) => LoginService(ref.read(localStorageRepositoryProvider), ref.read(ticTacToeBattleBackendRepositoryProvider)),
);

/// BattleService
final StateNotifierProvider<BattleService, BattleSituation> battleServiceProvider = StateNotifierProvider((ref) =>
    BattleService(ref.read(localStorageRepositoryProvider), ref.read(ticTacToeBattleBackendRepositoryProvider)));

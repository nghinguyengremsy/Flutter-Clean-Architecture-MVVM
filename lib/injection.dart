import 'dart:async';

import 'package:get_it/get_it.dart';

import 'data/data_source/remote/pokemon_api.dart';
import 'data/data_source/remote/pokemon_api.impl.dart';
import 'data/repository/pokemon_repository.impl.dart';
import 'domain/repositories/pokemon_repository.dart';
import 'domain/usecases/get_pokemon_list_usecase.dart';

FutureOr<void> injectDependencies() {
  GetIt.I.registerLazySingleton<PokemonApi>(() => PokemonApiImpl());
  GetIt.I.registerLazySingleton<PokemonRepository>(
      () => PokemonRepositoryImpl(GetIt.I<PokemonApi>()));
  GetIt.I.registerLazySingleton<GetPokemonListUseCase>(
      () => GetPokemonListUseCase(GetIt.I<PokemonRepository>()));
}

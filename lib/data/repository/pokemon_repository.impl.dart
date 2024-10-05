import 'package:flutter_cleanarchitecture_mvvm/data/data_source/remote/pokemon_api.dart';
import 'package:flutter_cleanarchitecture_mvvm/domain/repositories/pokemon_repository.dart';

import '../../domain/entities/pokemon.dart';
import '../mapper/pokemon_mapper.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApi _pokemonApi;
  PokemonRepositoryImpl(this._pokemonApi);

  @override
  Future<List<Pokemon>> getPokemonList() async {
    final ls = await _pokemonApi.getPokemonList();
    return ls.map(PokemonMapper.mapToPokemon).toList();
  }
}

import 'package:flutter_cleanarchitecture_mvvm/data/model/Pokemon.dart';
import 'package:flutter_cleanarchitecture_mvvm/domain/BaseUseCase.dart';
import 'package:flutter_cleanarchitecture_mvvm/data/repository/PokemonRepository.dart';

class GetPokemonListUseCase extends BaseUseCase<List<Pokemon>> {
  late PokemonRepository _pokemonRepository;

  GetPokemonListUseCase(PokemonRepository pokemonRepository) {
    this._pokemonRepository = pokemonRepository;
  }

  @override
  Future<List<Pokemon>> perform() {
    return _pokemonRepository.getPokemonList();
  }
}

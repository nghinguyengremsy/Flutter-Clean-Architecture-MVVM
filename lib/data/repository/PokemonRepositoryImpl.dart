import 'package:flutter_cleanarchitecture_mvvm/data/model/Pokemon.dart';
import 'package:flutter_cleanarchitecture_mvvm/data/remote/PokemonApi.dart';
import 'package:flutter_cleanarchitecture_mvvm/data/repository/PokemonRepository.dart';

class PokemonRepositoryImpl implements PokemonRepository{
  late PokemonApi _pokemonApi;
  PokemonRepositoryImpl(PokemonApi pokemonApi){
    this._pokemonApi = pokemonApi;
  }

  @override
  Future<List<Pokemon>> getPokemonList() {
    return _pokemonApi.getPokemonList();
  }
}
import 'package:flutter_cleanarchitecture_mvvm/data/model/pokemon.dart';

abstract class PokemonApi{
  Future<List<PokemonModel>> getPokemonList();
}
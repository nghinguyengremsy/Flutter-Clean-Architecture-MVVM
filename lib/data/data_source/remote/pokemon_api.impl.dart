import 'dart:convert';

import 'package:flutter_cleanarchitecture_mvvm/data/model/pokemon.dart';
import 'package:flutter_cleanarchitecture_mvvm/data/data_source/remote/pokemon_api.dart';
import 'package:http/http.dart';

class PokemonApiImpl implements PokemonApi {
  @override
  Future<List<PokemonModel>> getPokemonList() async {
    try {
      final response = await get(Uri.parse(
          'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'));
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        var list = mapResponse['pokemon'] as List;
        final listPokemon = <PokemonModel>[];
        for (var idx = 0; idx < list.length; idx++) {
          PokemonModel pokemon = PokemonModel(
            name: list.asMap()[idx]['name'],
            url: list.asMap()[idx]['img'],
            weight: list.asMap()[idx]['weight'],
            height: list.asMap()[idx]['height'],
          );
          listPokemon.add(pokemon);
        }
        return listPokemon;
      } else {
        throw Exception("Error Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("There was a problem with the connection");
    }
  }
}

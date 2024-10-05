import '../../domain/entities/pokemon.dart';
import '../model/pokemon.dart';

class PokemonMapper {
  static Pokemon mapToPokemon(PokemonModel model) {
    return Pokemon(
      name: model.name,
      url: model.url,
      weight: model.weight,
      height: model.height,
    );
  }
}

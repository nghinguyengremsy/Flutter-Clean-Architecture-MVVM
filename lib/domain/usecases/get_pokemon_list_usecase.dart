import 'dart:async';
import '../../core/usecases/base_usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonListUseCase extends BaseUsecase<void, List<Pokemon>> {
  final PokemonRepository _pokemonRepository;

  GetPokemonListUseCase(this._pokemonRepository);

  @override
  FutureOr<List<Pokemon>> call(void input) {
    return _pokemonRepository.getPokemonList();
  }
}

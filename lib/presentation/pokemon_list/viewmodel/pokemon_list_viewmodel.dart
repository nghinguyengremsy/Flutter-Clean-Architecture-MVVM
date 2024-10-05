import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/entities/pokemon.dart';
import '../../../domain/usecases/get_pokemon_list_usecase.dart';

class ViewModelPokemonList {
  final _pokemonListSubject = PublishSubject<List<Pokemon>>();

  Stream<List<Pokemon>> get pokemonList => _pokemonListSubject.stream;
  final _getPokemonListUseCase = GetIt.I<GetPokemonListUseCase>();

  void getPokemonList() async {
    try {
      _pokemonListSubject.sink.add(await _getPokemonListUseCase.call(""));
    } catch (e) {
      await Future.delayed(Duration(milliseconds: 500));
      _pokemonListSubject.sink.addError(e);
    }
  }

  void closeObservable() {
    _pokemonListSubject.close();
  }
}

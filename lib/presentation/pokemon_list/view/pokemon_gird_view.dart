import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/mp_circle_avatar.dart';
import '../../../domain/entities/pokemon.dart';
import '../viewmodel/pokemon_list_viewmodel.dart';

class ViewPokemonGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildPokemonContent());
  }

  Widget buildPokemonContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PokemonListView(),
        ],
      ),
    );
  }
}

class PokemonListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PokemonListViewState();
  }
}

class PokemonListViewState extends State<PokemonListView>
    with WidgetsBindingObserver {
  final ViewModelPokemonList viewModelPokemonList = ViewModelPokemonList();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (!result.contains(ConnectivityResult.none)) {
        refresh();
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    viewModelPokemonList.closeObservable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Pokemon>>(
      stream: viewModelPokemonList.pokemonList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildCircularProgressIndicatorWidget();
        }
        if (snapshot.hasError) {
          showSnackBar(context, snapshot.error.toString());
          return buildListViewNoDataWidget();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          var pokemonList = snapshot.data;
          if (null != pokemonList)
            return buildGridViewWidget(pokemonList);
          else
            return buildListViewNoDataWidget();
        }
        return const SizedBox();
      },
    );
  }

  Widget buildGridViewWidget(List<Pokemon> pokemonList) {
    return Flexible(
        child: GridView.builder(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            itemCount: 20,
            scrollDirection: Axis.horizontal,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              var item = pokemonList[index];
              var _colors = Colors.primaries;
              final MaterialColor color = _colors[index % _colors.length];
              return new GestureDetector(
                child: new Card(
                  elevation: 5.0,
                  child: new Container(
                    alignment: Alignment.center,
                    child: new Hero(
                      tag: item.name,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: avatar(item.url, color),
                          ),
                          new Text(
                            "Weight: ${item.weight}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          new Text(
                            "Height: ${item.height} ",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  Widget buildListViewNoDataWidget() {
    return Expanded(
      child: Center(
        child: Text("No Data Available"),
      ),
    );
  }

  Widget buildCircularProgressIndicatorWidget() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void showSnackBar(BuildContext context, String errorMessage) async {
    await Future.delayed(Duration.zero);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  void refresh() {
    viewModelPokemonList.getPokemonList();
    setState(() {});
  }
}

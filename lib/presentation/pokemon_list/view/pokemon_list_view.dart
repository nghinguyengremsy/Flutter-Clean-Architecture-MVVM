import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/mp_circle_avatar.dart';
import '../../../domain/entities/pokemon.dart';
import '../../pokemon_detail/pokemon_detail_view.dart';
import '../viewmodel/pokemon_list_viewmodel.dart';

class ViewPokemonList extends StatelessWidget {
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
            return buildListViewWidget(pokemonList);
          else
            return buildListViewNoDataWidget();
        }
        return const SizedBox();
      },
    );
  }

  Widget buildListViewWidget(List<Pokemon> pokemonList) {
    return Flexible(
        child: new ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: pokemonList.length,
      itemBuilder: (BuildContext context, int index) {
        var item = pokemonList[index];
        var _colors = Colors.primaries;
        final MaterialColor color = _colors[index % _colors.length];
        return new ListTile(
          dense: false,
          leading: new Hero(
            child: avatar(item.url, color),
            tag: item.name,
          ),
          title: new Text(item.name),
          subtitle: new Text(
            "Weight: ${item.weight} Height: ${item.height} ",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ViewPokemonDetail()));
          },
        );
      },
    ));
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

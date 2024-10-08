import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cleanarchitecture_mvvm/main.dart';
import 'package:flutter_cleanarchitecture_mvvm/presentation/camera/camera_screen.dart';
import 'package:flutter_cleanarchitecture_mvvm/presentation/photo/photo_staggered_view.dart';
import 'package:flutter_cleanarchitecture_mvvm/presentation/pokemon_list/view/pokemon_gird_view.dart';
import 'package:flutter_cleanarchitecture_mvvm/presentation/pokemon_list/view/pokemon_list_view.dart';
import 'package:flutter_cleanarchitecture_mvvm/core/utils/AppLocalizations.dart';

class PokemonHome extends StatefulWidget {
  final List<CameraDescription> cameras;

  PokemonHome(this.cameras);

  @override
  _PokemonHomeState createState() => new _PokemonHomeState();
}

class _PokemonHomeState extends State<PokemonHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).translate('name_app')),
        elevation: 0.7,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(text: "LIST"),
            new Tab(
              text: "GRID",
            ),
            new Tab(
              text: "STAGGER",
            ),
          ],
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: () => _onClickCamera(context)),
          new Icon(Icons.more_vert)
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new ViewPokemonList(),
          new ViewPokemonGrid(),
          new ViewPhotoStaggered(),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).indicatorColor,
          child: new Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () => _showToast(context)),
    );
  }

  _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Hello!'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

_onClickCamera(BuildContext context) {
  print("OnClick Camera!!");
  Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new CameraScreen(cameras)));
}

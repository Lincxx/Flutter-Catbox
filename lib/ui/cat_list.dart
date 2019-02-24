import 'package:flutter/material.dart';
import '../models/cat.dart';
import '../services/api.dart';
import 'dart:async';

class CatList extends StatefulWidget {
  @override
  _CatListState createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  List<Cat> _cats = [];

  @override
  void initState() {
    super.initState();
    _loadCats();
  }

  _loadCats() async {
    String fileData =
        await DefaultAssetBundle.of(context).loadString("assets/cats.json");
    // for (Cat cat in CatApi.allCatsFromJson(fileData)) {
    //   _cats.add(cat);
    // }

    setState(() {
      _cats = CatApi.allCatsFromJson(fileData);
    });
  }

  Widget _getAppTitleWidget() {
    return Text(
      'Cats',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 56.0, 8.0, 0),
      child: Column(
        children: <Widget>[_getAppTitleWidget(), _getListViewWidget()],
      ),
    );
  }

  Widget _buildCatItem(BuildContext context, int index) {
    Cat cat = _cats[index];

    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              //onTap: //TODO
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(cat.avatarUrl),
                ),
              ),
              title: new Text(
                cat.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              subtitle: new Text(cat.description),
              isThreeLine: true, // Less Cramped Tile
              dense: false, // Less Cramped Tile
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> refresh() {
    _loadCats();
    return Future<Null>.value();
  }

  Widget _getListViewWidget() {
    return Flexible(
        child: RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _cats.length,
              itemBuilder: _buildCatItem,
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pexel_app/utils/db_provider.dart';

import 'favorite_view.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  dynamic _fetchedFavorites = [];

  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(getColorHexFromStr('#323232')),
        appBar: AppBar(
          title: Text('Favorites'),
          elevation: 0.0,
        ),
        body: _fetchedFavorites.isEmpty
        ? FutureBuilder(
          future: DatabaseHelper.instance.queryAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        size: 50,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('No Favorites', style: TextStyle(color: Colors.redAccent, fontSize: 15.0),),
                    ],
                  ),
                );
              }
              _fetchedFavorites = snapshot.data.map(
                (favoriteWallpaper) => GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteView(
                      imgUrl: favoriteWallpaper['name'],
                    )));
                  },
                  child: Card(
                    margin: EdgeInsets.all(16),
                    elevation: 1,
                      child: Column(
                      children: <Widget>[
                        Hero(
                            tag: favoriteWallpaper['_id'],
                            child: Image.network(favoriteWallpaper['name'])),
                      ],
                    ),
                  ),
                ),
              );
              return _renderFavorites(forceRefresh: false);
            }
            return Center(
              child: CircularProgressIndicator(
              ),
            );
          },
        )
            : _renderFavorites(forceRefresh: true),
    );
  }

  Widget _renderFavorites({bool forceRefresh}) {
    if (forceRefresh) {
      DatabaseHelper.instance.queryAll().then((favorites) {
        if (favorites.length != _fetchedFavorites.length) {
          setState(() {
            _fetchedFavorites = [];
          });
        }
      });
    }
    return ListView(
      children: <Widget>[
        ..._fetchedFavorites,
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pexel_app/data/data.dart';
import 'package:pexel_app/model/wallpaper_model.dart';
import 'package:pexel_app/widgets/widget.dart';

class Categorie extends StatefulWidget {
  final String CategoryName;
  Categorie({this.CategoryName});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = new List();
  bool _loading = true;

  getSearchWallpapers(String query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=5000&page=1"),
        headers: {"Authorization": apiKey});

    // print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getSearchWallpapers(widget.CategoryName);
    super.initState();
  }

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
        title: Text('ICONIC'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
              ),

              _loading
                  ? Container(
                      height: MediaQuery.of(context).size.height / 1.15,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Container(
                      child: wallpapersList(
                          wallpapers: wallpapers, context: context),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pexel_app/data/data.dart';
import 'package:pexel_app/model/categories_model.dart';
import 'package:pexel_app/model/wallpaper_model.dart';
import 'package:pexel_app/views/search.dart';
import 'package:pexel_app/widgets/widget.dart';

import 'category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  bool _loading = true;

  TextEditingController searchController = new TextEditingController();

  getTrendindWallpapers() async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=Social and Cars and Animal and Nature&per_page=5000"),
        headers: {"Authorization": apiKey});

     print(response.body.toString());

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
    getTrendindWallpapers();
    categories = getCategories();
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
        elevation: 0.0,
        title: Text("ICONIC"),
        backgroundColor: Color(getColorHexFromStr('#323232')),
      ),

      // Navigation drawer
      drawer: Sidenav(),

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
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search wallpapers",
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                      searchQuery: searchController.text,
                                    )));
                      },
                      child: Container(child: Icon(Icons.search)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 60,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        title: categories[index].categorieName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
              ),
              SizedBox(
                height: 16,
              ),

              // Loading
              _loading
                  ? Container(
                      height: MediaQuery.of(context).size.height / 1.67,
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

// Navigation drawer function
class Sidenav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ICONIC',
              style: TextStyle(fontSize: 21, color: Colors.red),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),

          ListTile(
            title: Text(
              'Favorites',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            // trailing: Text( '7' , style: TextStyle(fontWeight: FontWeight.w500),),
            onTap: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),

          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onTap: () {},
          ),

          ListTile(
            title: Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.info,
              color: Colors.black,
            ),
            onTap: () {
              showAboutDialog(context: context);
            },
          ),

          // ListTile(
          //   title: Text('Scheduled'),
          //   leading: Icon(Icons.local_offer,  color: Colors.black,),
          //   onTap: (){
          //
          //   },
          // ),
        ],
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                      CategoryName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  imgUrl,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(100),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}

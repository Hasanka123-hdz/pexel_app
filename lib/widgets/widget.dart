import 'package:flutter/material.dart';
import 'package:pexel_app/model/wallpaper_model.dart';
import 'package:pexel_app/views/image_view.dart';

Widget wallpapersList({List<WallpaperModel> wallpapers, BuildContext context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: GridView.count(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio:0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing:6.0 ,
      children: wallpapers.map((wallpaper) {
          return GridTile(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ImageView(
                        imgUrl: wallpaper.src.portrait,
                      )
                  ));
                },
                child: Hero(
                  tag:wallpaper.src.portrait,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xfff5f8fd),
                        borderRadius: BorderRadius.circular(7)
                    ),
                   child: ClipRRect(
                       borderRadius: BorderRadius.circular(7),
                       child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
                  ),
                ),
              )
          );
      }).toList(),
    ),
  );
}
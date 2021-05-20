class WallpaperModel{

  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;
  int height;

  WallpaperModel({this.photographer,this.photographerUrl,this.photographerId,this.src,this.height});

  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData )
  {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographerUrl: jsonData["photographerUrl"],
      photographerId: jsonData["photographerId"],
      photographer: jsonData["photographer"],
      height: jsonData["height"]
    );
  }
}

class SrcModel extends WallpaperModel{

  String original;
  String landscape;
  String portrait;

  SrcModel({this.original,this.landscape,this.portrait});

  factory SrcModel.fromMap(Map<String,dynamic> jsonData){

    return SrcModel(
        portrait: jsonData["portrait"],
        original: jsonData["original"],
        landscape: jsonData["landscape"],
    );
  }

}
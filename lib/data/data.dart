import 'package:pexel_app/model/categories_model.dart';

String apiKey="563492ad6f9170000100000134b7a5985e544a939c03831df7366956";

List<CategoriesModel> getCategories()
{
  List<CategoriesModel> categories=new List();
   CategoriesModel categoriesModel=new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1589187832032-3e560ed4e6b9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTIxfHxzdHlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoriesModel.categorieName = "Fashion";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();


  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1513207565459-d7f36bfa1222?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=335&q=80";
  categoriesModel.categorieName = "Girls";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1567589391022-aadc3e17b01a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80";
  categoriesModel.categorieName = "Boys";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1541580621-39f717ce77cd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80";
  categoriesModel.categorieName = "Street Art";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1527073620320-77635188c627?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80";
  categoriesModel.categorieName = "Wild Life";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1588392382834-a891154bca4d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80";
  categoriesModel.categorieName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1465447142348-e9952c393450?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80";
  categoriesModel.categorieName = "City";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1549060279-7e168fcee0c2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzN8fG1vdGl2YXRpb258ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  categoriesModel.categorieName = "Motivation";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80";
  categoriesModel.categorieName = "Bikes";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.imgUrl =
  "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80";
  categoriesModel.categorieName = "Cars";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  return categories;
}
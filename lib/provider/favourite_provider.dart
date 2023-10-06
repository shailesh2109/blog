import 'package:flutter/foundation.dart';

class FavouriteBlogProvider with ChangeNotifier{

  List<String> _selectedBlog=[];
  List<String> _favouriteImage=[];
  List<String> _favouriteTitle=[];


  List<String> get selectedBlog=> _selectedBlog;
  List<String> get favouriteImage=> _favouriteImage;
  List<String> get favouriteTitle=> _favouriteTitle;


  void addItem(String value,String image,String title){
    _selectedBlog.add(value);
    _favouriteImage.add(image);
    _favouriteTitle.add(title);
    notifyListeners();
  }

  void removeItem(String value,String image,String title){
    _selectedBlog.remove(value);
    _favouriteImage.remove(image);
    _favouriteTitle.remove(title);
    notifyListeners();
  }

}
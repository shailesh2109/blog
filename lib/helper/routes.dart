import 'package:flutter/material.dart';
import 'package:sub_space/models/blog_model.dart';
import 'package:sub_space/screens/details_home.dart';
import 'package:sub_space/screens/favourite_list.dart';
import 'package:sub_space/screens/home.dart';

class MyRoutes{
  static home(BuildContext context)=>
   Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));

   static favourite(BuildContext context)=>
   Navigator.push(context, MaterialPageRoute(builder: (context)=>FavouriteList()));

   static detailsHome(BuildContext context,Widget page)=>
   Navigator.push(context, MaterialPageRoute(builder: (context)=>page));

}
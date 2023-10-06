import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_space/helper/helper.dart';
import 'package:sub_space/helper/routes.dart';
import 'package:sub_space/models/blog_model.dart';
import 'package:sub_space/provider/favourite_provider.dart';
import 'package:sub_space/screens/details_home.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    final favouriteProvider=Provider.of<FavouriteBlogProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      MyRoutes.home(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(width: MediaQuery.sizeOf(context).width*.25,),
                    const Text("Favourite",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                ],
              ),
      
              Expanded(
                child: ListView.builder(itemCount: favouriteProvider.selectedBlog.length,itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Image.network(favouriteProvider.favouriteImage[index],width: ModifiedConstraints.width(context),fit: BoxFit.fitWidth,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(favouriteProvider.favouriteTitle[index],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  
              ),
            ],
          ),
      ),
    );
  }
}
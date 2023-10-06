import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_space/helper/routes.dart';
import 'package:sub_space/models/blog_model.dart';
import 'package:sub_space/provider/favourite_provider.dart';

class DetailsHome extends StatelessWidget {
  final BlogModel catalog;

  const DetailsHome({super.key, required this.catalog});


  @override
  Widget build(BuildContext context) {
    print(build);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        MyRoutes.favourite(context);
      },child: Icon(Icons.favorite),),
      body: SafeArea(child: Column(
        children: [
          Row(
            children: [
              IconButton(
                    onPressed: () {
                      MyRoutes.home(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                    Spacer(),
                    Consumer<FavouriteBlogProvider>(builder: (context, value, child) {
                      return IconButton(onPressed: () {
                        if(value.selectedBlog.contains(catalog.id)){
                          value.removeItem(catalog.id,catalog.imageUrl,catalog.title);
                          print(value.selectedBlog);
                        }
                        else{
                          value.addItem(catalog.id,catalog.imageUrl,catalog.title);
                          print(value.selectedBlog);
                        }
                      }, icon: Icon(
                        value.selectedBlog.contains(catalog.id)?Icons.favorite:Icons.favorite_border_outlined));
                    },
                    )
            ],
          ),
          Image.network(catalog.imageUrl),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(catalog.title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          )
        ],
      )),
    );
  }
}
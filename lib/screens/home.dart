import 'package:flutter/material.dart';
import 'package:sub_space/helper/routes.dart';
import 'package:sub_space/models/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sub_space/helper/helper.dart';
import 'package:sub_space/screens/details_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String substring='slate';
  void closeAppUsingSystemPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  @override
  void initState(){
    super.initState();
    getData();
  }

    getData()async{
     final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      final data=jsonDecode(response.body.toString());
      print(data);
      final finalData=data["blogs"];
      print(finalData);
      for(Map<String,dynamic> index in finalData){
        if(BlogModel.fromJson(index).imageUrl.contains(substring)){
          continue;
        }
        else{
            BlogList.catalogModel.add(BlogModel.fromJson(index));
        }
        
      }
      print(BlogList.catalogModel);
      return BlogList.catalogModel;
      
    } else {
      print('Request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      return BlogList.catalogModel;
    }
  } catch (e) {
    print('Error: $e');
    return BlogList.catalogModel;
  }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        MyRoutes.favourite(context);
      },child: Icon(Icons.favorite),),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      closeAppUsingSystemPop();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(width: MediaQuery.sizeOf(context).width*.25,),
                    const Text("ubSpace",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                ],
              ),
      
              Expanded(
                child: FutureBuilder(
                  future: getData(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(itemCount: BlogList.catalogModel.length,itemBuilder: (context,index){
                        final catalog=BlogList.catalogModel[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: ()=>MyRoutes.detailsHome(context, DetailsHome(catalog:catalog)),
                          child: Hero(
                            tag: Key(catalog.id.toString()),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.network(BlogList.catalogModel[index].imageUrl,width: ModifiedConstraints.width(context),fit: BoxFit.fitWidth,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(BlogList.catalogModel[index].title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                    }
                    else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
                ),
              ),
            ],
          ),
      ),
    );
  }
}
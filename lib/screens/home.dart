import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:sub_space/models/blog_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sub_space/helper/helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void closeAppUsingSystemPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  @override
  void initState(){
    super.initState();
    getData();
  }
  List<BlogModel> catalogModel=[];

    getData()async{
     final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      // Request successful, handle the response data here
      print('Response data: ${response.body}');
      final data=jsonDecode(response.body.toString());
      final finalData=data["blogs"];
      for(Map<String,dynamic> index in finalData){
        catalogModel.add(BlogModel.fromJson(index));
      }
      print(catalogModel);
      return catalogModel;
      
    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      return catalogModel;
    }
  } catch (e) {
    // Handle any errors that occurred during the request
    print('Error: $e');
    return catalogModel;
  }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text("ubSpace",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                ],
              ),
      
              Expanded(
                child: FutureBuilder(
                  future: getData(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(itemCount: catalogModel.length,itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.network(catalogModel[index].imageUrl,width: ModifiedConstraints.width(context),fit: BoxFit.fitWidth,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(catalogModel[index].title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                          ],
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
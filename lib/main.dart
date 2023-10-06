import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_space/provider/favourite_provider.dart';
import 'package:sub_space/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>FavouriteBlogProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home()
        
      ),
    );
  }
}
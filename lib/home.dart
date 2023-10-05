import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemCount: 1,itemBuilder: (context,index){
        return Container(
        height: 100,
        padding: EdgeInsets.all(16),
        color: Colors.greenAccent,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Text("hello"),
          ],
        ),
      );
      })
    );
  }
}
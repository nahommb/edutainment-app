import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('lee'),centerTitle: true,backgroundColor: Colors.red,),
      body: Center(
        child: Text('Ready'),
      ),
    );
  }
}

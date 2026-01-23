import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(12), child: Column(
          children: [],
        ),),
      )),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add),),
    );
  }
}

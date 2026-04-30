import 'package:flutter/material.dart';

class HomeScreenHomeTab extends StatefulWidget {
  const HomeScreenHomeTab({super.key});

  @override
  State<HomeScreenHomeTab> createState() => _HomeScreenHomeTabState();
}

class _HomeScreenHomeTabState extends State<HomeScreenHomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("Home")]);
  }
}

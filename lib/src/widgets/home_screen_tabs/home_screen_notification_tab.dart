import 'package:flutter/material.dart';

class HomeScreenNotificationTab extends StatefulWidget {
  const HomeScreenNotificationTab({super.key});

  @override
  State<HomeScreenNotificationTab> createState() =>
      _HomeScreenNotificationTabState();
}

class _HomeScreenNotificationTabState extends State<HomeScreenNotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("Notification")]);
  }
}

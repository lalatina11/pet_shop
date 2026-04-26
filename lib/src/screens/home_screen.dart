import 'package:flutter/material.dart';
import 'package:pet_shop/src/screens/auth_screen.dart';
import 'package:pet_shop/src/widgets/mode_toggle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => HomeScreen());
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [Text("Daftar Peliharaan"), ModeToggle()],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(AuthScreen.route());
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

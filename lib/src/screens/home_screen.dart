import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_cubit.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/widget_color_generator.dart';
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
  final _color = WidgetColorGenerator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [Text("Daftar Peliharaan"), ModeToggle()],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: _color.getPrimaryColor(),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.of(context).push(AuthScreen.route());
          }
        },
        builder: (context, state) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              child: Text(
                "LogOut",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}

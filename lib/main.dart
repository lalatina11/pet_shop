import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_shop/src/lib/cubits/theme_cubit.dart';
import 'package:pet_shop/src/lib/cubits/theme_state.dart';
import 'package:pet_shop/src/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  final themeCubit = ThemeCubit(sharedPreferences: sp);

  themeCubit.loadTheme();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider.value(value: themeCubit)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode getTheme(ThemeState state) {
    switch (state) {
      case ThemeState.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: .fromSeed(
              seedColor: Colors.deepPurple,
              brightness: state == ThemeState.dark
                  ? Brightness.dark
                  : Brightness.light,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorStyle: TextStyle(fontSize: 16),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(.infinity, 50),
              ),
            ),
          ),
          themeMode: getTheme(state),
          home: const HomeScreen(),
        );
      },
    );
  }
}

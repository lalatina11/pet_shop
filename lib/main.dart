import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_cubit.dart';
import 'package:pet_shop/src/lib/cubits/auth/auth_state.dart';
import 'package:pet_shop/src/lib/cubits/theme/theme_cubit.dart';
import 'package:pet_shop/src/lib/cubits/theme/theme_state.dart';
import 'package:pet_shop/src/lib/widget_color_generator.dart';
import 'package:pet_shop/src/screens/auth_screen.dart';
import 'package:pet_shop/src/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final sp = await SharedPreferences.getInstance();
  final themeCubit = ThemeCubit(sharedPreferences: sp);
  themeCubit.loadTheme();

  final authCubit = AuthCubit(sharedPreferences: sp);
  await authCubit.checkIsLoggedIn();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: authCubit),
      ],
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
  final _color = WidgetColorGenerator();
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
            brightness: state == ThemeState.dark
                ? Brightness.dark
                : Brightness.light,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorStyle: TextStyle(fontSize: 16),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                backgroundColor: _color.getPrimaryColor(),
                minimumSize: Size(.infinity, 50),
              ),
            ),
            appBarTheme: AppBarThemeData(
              backgroundColor: _color.getPrimaryColor(),
            ),
          ),
          themeMode: getTheme(state),
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is AuthLoggedIn) {
                return HomeScreen();
              }
              return AuthScreen();
            },
          ),
          // home: HomeScreen(),
        );
      },
    );
  }
}
